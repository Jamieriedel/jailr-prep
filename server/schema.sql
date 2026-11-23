-- JAILR Prep: Konten und Abgleich. Einmal im SQL-Editor des (EU-)Projekts ausführen.
-- Jede Person sieht und ändert ausschließlich ihre eigenen Zeilen (Row Level Security).
create table if not exists public.jailr_items (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  kind text not null check (kind in ('track','set','settings')),
  key text not null check (char_length(key) between 1 and 400),
  data jsonb check (data is null or pg_column_size(data) < 32768),
  updated_at timestamptz not null default now(),
  primary key (user_id, kind, key)
);
create index if not exists jailr_items_sync on public.jailr_items (user_id, updated_at);

alter table public.jailr_items enable row level security;
revoke all on public.jailr_items from anon, authenticated, public;
grant select, insert, update, delete on public.jailr_items to authenticated;

drop policy if exists jailr_select on public.jailr_items;
drop policy if exists jailr_insert on public.jailr_items;
drop policy if exists jailr_update on public.jailr_items;
drop policy if exists jailr_delete on public.jailr_items;
create policy jailr_select on public.jailr_items for select to authenticated using (user_id = (select auth.uid()));
create policy jailr_insert on public.jailr_items for insert to authenticated with check (user_id = (select auth.uid()));
create policy jailr_update on public.jailr_items for update to authenticated using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy jailr_delete on public.jailr_items for delete to authenticated using (user_id = (select auth.uid()));

-- Zeitstempel setzt immer der Server; Obergrenze gegen Missbrauch
create or replace function public.jailr_touch() returns trigger language plpgsql set search_path = '' as $$
begin
  new.updated_at := clock_timestamp();
  if tg_op = 'INSERT' and (select count(*) from public.jailr_items where user_id = new.user_id) >= 30000 then
    raise exception 'Speicherlimit erreicht';
  end if;
  return new;
end $$;
drop trigger if exists jailr_touch on public.jailr_items;
create trigger jailr_touch before insert or update on public.jailr_items for each row execute function public.jailr_touch();

-- Konto samt allen Daten sofort löschen (Art. 17 DSGVO), nur das eigene
create or replace function public.jailr_delete_account() returns void language plpgsql security definer set search_path = '' as $$
begin
  if auth.uid() is null then raise exception 'nicht angemeldet'; end if;
  delete from public.jailr_items where user_id = auth.uid();
  delete from auth.users where id = auth.uid();
end $$;
revoke all on function public.jailr_delete_account() from public, anon;
grant execute on function public.jailr_delete_account() to authenticated;

-- Aufräumen: gelöschte Einträge (data is null) nach 180 Tagen, nie genutzte Konten nach 24 Monaten.
-- Monatlich ausführen (SQL-Editor oder pg_cron).
create or replace function public.jailr_cleanup() returns void language plpgsql security definer set search_path = '' as $$
begin
  delete from public.jailr_items where data is null and updated_at < now() - interval '180 days';
  delete from auth.users where coalesce(last_sign_in_at, created_at) < now() - interval '24 months';
end $$;
revoke all on function public.jailr_cleanup() from public, anon, authenticated;
