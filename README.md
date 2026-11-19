# JAILR Prep – Cue & Energy Lab

Kostenloses Browser-Tool zur Track-Vorbereitung für rekordbox (und Serato).

**→ App öffnen: https://jamieriedel.github.io/jailr-prep/**

Läuft komplett lokal im Browser. Es wird nichts hochgeladen – die Seite ist per Content-Security-Policy so gesperrt, dass sie technisch keine Daten senden kann. Keine externen Schriften, kein Tracking, keine Abhängigkeiten.

## Was es macht

- **Hot Cue A** auf den ersten Downbeat
- **Hot Cue F + G** als 32-Beat-Mix-Out-Fenster (8 Takte, einstellbar) vor dem Energieabfall am Ende
- **Exit Loop** (8 Bars) als Memory Cue, damit der Track nicht ausläuft
- **Energie 1–5** als Rating (Tempo, Dichte, Drive, Bass, Höhen – unabhängig von der Master-Lautstärke), per Klick überschreibbar
- **Lautstärke (LUFS) & Gain-Empfehlung** relativ zur Playlist, Hinweise zu niedriger Bitrate und Übersteuerung
- **Mehrfach-Sortierung** nach Key (Camelot), BPM, Energie u. a. gleichzeitig
- **Export** nach rekordbox (XML) – als neue Playlist oder bestehende überschreiben – oder nach **Serato**: Crates plus **Hot Cues und Exit Loop direkt in die MP3s** (als Kopie oder in die Originale, Ton bleibt bitgenau gleich; Chrome/Edge)
- **Problemliste (CSV)** mit allem, was nicht automatisch ging, und was zu tun ist

## Zwei Wege rein

1. **rekordbox XML (empfohlen):** rekordbox → *Datei → Collection im xml-Format exportieren*, XML laden, Musikordner verbinden.
2. **USB-Stick:** den ganzen rekordbox-Stick (mit `PIONEER`-Ordner) wählen – Playlists, Beatgrids und Musik kommen in einem Schritt. Achtung: Ein XML-Export aus dieser Quelle zeigt auf die Dateien auf dem Stick; liegen die Tracks in deiner Library woanders, legt rekordbox sie doppelt an.

## Sicherheitsnetz

- Vor dem Download zeigt eine **Vorschau** jede Änderung (neu / ersetzt / bleibt).
- Jede Cue wird **geprüft** (im Track, A ≤ F < G, Loop mit Länge), die fertige XML wird noch einmal **selbst eingelesen und kontrolliert**.
- Tracks mit **unsicherer Erkennung** werden erst nach deiner Bestätigung (`C`) verändert.
- Tracks mit **Fehlern** (Datei fehlt, nicht lesbar, kein Beatgrid, zu lang) werden nie verändert.
- Vorhandene Hot Cues bleiben standardmäßig erhalten. Rückgängig mit `⌘Z`.

**Trotzdem: vor jedem Import ein Backup der rekordbox-Library machen** und beim ersten Mal mit 2–3 Tracks testen.

## Hinweise

- Empfohlen: Chrome oder Edge am Desktop. Safari geht, Mobile nicht.
- Die Energie-Bewertung ist eine Heuristik. Im Zweifel zählt dein Ohr – eigener Wert per Klick.
- Serato-Cues: aktuell nur MP3. Vorhandene Serato-Cues bleiben erhalten (außer „überschreiben“ ist an). Bei MP3s kann es zwischen rekordbox und Serato einen minimalen Zeitversatz geben – beim ersten Mal einen Cue in Serato gegenprüfen.

## Entwicklung

`index.html` ist gebaut aus `src/src.html` (`python3 src/build.py index.html`): bettet die Schrift ein und setzt den CSP-Hash des Skripts.
Schrift: Space Grotesk (SIL Open Font License).

Made by JAILR.
