# Konten einschalten

Bis `src/config.json` Werte hat, ist die Kontofunktion komplett aus und die App sendet nichts.

1. **Supabase**: Projekt anlegen, Region **Central EU (Frankfurt)**. Vertrag zur Auftragsverarbeitung (DPA) ansehen und ablegen.
2. **SQL Editor**: `server/schema.sql` einfügen und ausführen.
3. **E-Mail-Versand**: eigenen SMTP-Dienst eintragen (Authentication → SMTP). Der eingebaute Versand erreicht nur Mitglieder des Projekt-Teams und höchstens 2 Mails pro Stunde.
4. **E-Mail-Vorlagen** (Magic Link und Confirm signup): Text mit Code statt Link, z. B. `Dein Code für JAILR Prep: {{ .Token }}`
5. **Adresse und öffentlicher Schlüssel** (Project URL, publishable/anon key; niemals den service_role/secret key) in `src/config.json` bei `api` und `key` eintragen, dann `python3 src/build.py`.
6. **Rechtstexte**: `server/datenschutz-konto.html` ausfüllen und in `JAILR-Prep/datenschutz.html` an der Stelle `<!--KONTO-->` einsetzen, Nutzungsbedingungen ergänzen.
7. **Testen** mit zwei eigenen Adressen: anmelden, ändern, zweites Gerät, Konto löschen.
8. **Monatlich** `select public.jailr_cleanup();` ausführen.
