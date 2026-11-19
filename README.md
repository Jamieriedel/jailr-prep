# JAILR Prep – Cue & Energy Lab

Kostenloses Browser-Tool zur Track-Vorbereitung für rekordbox (und Serato).

**→ App öffnen: https://jamieriedel.github.io/jailr-prep/**

Läuft komplett lokal im Browser. Es wird nichts hochgeladen, deine Musik und deine Library bleiben auf deinem Rechner.

## Was es macht

- **Hot Cue A** auf den ersten Downbeat
- **Hot Cue F + G** als 32-Bar-Mix-Out-Fenster vor dem Energieabfall am Ende
- **Exit Loop** (8 Bars) als Memory Cue, damit der Track nicht ausläuft
- **Energie 1–5** als Rating, unabhängig von der Lautstärke des Masters
- **Lautstärke (LUFS) & Gain-Empfehlung** relativ zur Playlist, plus Hinweise zu niedriger Bitrate und Clipping
- **Mehrfach-Sortierung** nach Key (Camelot), BPM und Energie gleichzeitig
- **Export** zurück nach rekordbox (XML) oder als **Serato-Crates** (ZIP)

## So geht's

1. rekordbox → *Datei → Collection im xml-Format exportieren*
2. App öffnen, XML laden, Musikordner wählen
3. Playlist analysieren, Cues prüfen (Marker lassen sich verschieben und anhören)
4. *Export → rekordbox XML* und die Playlist über *rekordbox xml → Rechtsklick → In Collection importieren* zurückholen. Die genaue Anleitung steht in der App unter „?“.

**Vorher immer ein Backup der rekordbox-Library machen.** Der Import überschreibt bei den betroffenen Tracks die Cues mit dem Stand aus der XML.

## Hinweise

- Empfohlen: Chrome oder Edge (Desktop). Safari funktioniert, Mobile nicht.
- Die Tracks müssen in rekordbox analysiert sein (Beatgrid).
- Die Energie-Bewertung ist eine Heuristik aus Tempo, Dichte, Drive, Bass und Höhen. Im Zweifel zählt dein Ohr.
- Serato-Export überträgt Playlists, keine Cues.

Made by JAILR.
