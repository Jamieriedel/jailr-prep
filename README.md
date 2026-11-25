# JAILR Prep – Cue & Energy Lab

Kostenloses Browser-Tool zur Track-Vorbereitung für rekordbox (und Serato).

**→ App öffnen: https://jamieriedel.github.io/jailr-prep/**

Läuft komplett lokal im Browser. Es wird nichts hochgeladen – die Seite ist per Content-Security-Policy so gesperrt, dass sie technisch keine Daten senden kann. Keine externen Schriften, kein Tracking, keine Abhängigkeiten.

## Was es macht

- **Cues sind optional:** erst analysieren, dann pro Playlist oder Track bewusst einschalten
- **Hot Cue A** auf dem ersten Downbeat, an dem der Kick durchgehend einsetzt, auf der Phrase
- **Hot Cue B** (Bass Swap): spätestens hier im Track sein, am ersten vollen Abschnitt nach A
- **Hot Cue D + F**: erste Transition, genau 16 Takte voller Groove bis zu einem Abschnittsende
- **Hot Cue G + H** (zweite Transition) als 32-Beat-Mix-Out-Fenster: H am echten Energieabfall (Outro, Breakdown oder Trackende), nie mitten in Break oder Fill
- **Emergency Loop** als Memory Loop hinter H: 16, 8 oder 4 Beats, die längste Länge, die nahtlos läuft. Auf dem Stick als **Active Loop** schaltbar
- **Set-Planer:** Reihenfolge nach Key (Camelot), Tempo und Energiekurve, mit Score und Begründung pro Übergang, Export als rekordbox-Playlist oder Serato-Crate
- **Energie 1–5** als Rating (Tempo, Dichte, Drive, Bass, Höhen – unabhängig von der Master-Lautstärke), per Klick überschreibbar
- **Lautstärke (LUFS) & Gain-Empfehlung** relativ zur Playlist, Hinweise zu niedriger Bitrate und Übersteuerung
- **Mehrfach-Sortierung** nach Key (Camelot), BPM, Energie u. a. gleichzeitig
- **Export** nach rekordbox (XML) – als neue Playlist oder bestehende überschreiben – oder nach **Serato**: Crates plus **Hot Cues und Emergency Loop direkt in die MP3s** (als Kopie oder in die Originale, Ton bleibt bitgenau gleich; Chrome/Edge)
- **Quantize-Prüfung:** misst das rekordbox-Beatgrid am Audio (Versatz, Drift, Takt 1), mit Klick zum Anhören und optionaler Korrektur in der XML
- **Klarer Status pro Track:** Fertig, Quantize, Cues, Qualität oder Lautheit prüfen
- **Teilen:** Set oder Playlist als Link oder Datei, ohne Musik und ohne Server. Wer ihn öffnet, sieht, welche Tracks in der eigenen Library liegen, und kann passende Cues übernehmen
- **Set Master:** macht eine rekordbox-Aufnahme (WAV, optional CUE) fertig: misst Lautheit, True Peak und Übersteuerung, füllt Aussetzer mit einem Echo im Takt, gleicht Pegel an, begrenzt auf die Ziel-Lautheit und schreibt WAV, CUE, Tracklist und Report. Läuft blockweise im Web Worker, nichts wird hochgeladen
- **Übergänge anhören:** jeder Übergang im Set-Planer im Takt gemixt, Bass Swap auf B, Ausstieg auf H oder F, Lautheit angeglichen
- **Klang-Karte:** ähnlich klingende Tracks liegen beieinander (t-SNE auf den Fingerabdrücken der Analyse)
- **Offline:** als App installierbar (`pwa/`), Analyse auf allen Prozessorkernen
- **Problemliste (CSV)** mit allem, was nicht automatisch ging, und was zu tun ist

## Zwei Wege rein

1. **rekordbox XML (empfohlen):** rekordbox → *Datei → Collection im xml-Format exportieren*, XML laden, Musikordner verbinden.
2. **USB-Stick:** Stick, `PIONEER` oder `Contents` wählen (Chrome/Edge ohne „Hochladen“-Frage). Für den Rückweg nach rekordbox einmal die Collection-XML dazuladen: Die App ordnet jeden Track deiner Library zu, nur diese Pfade kommen in die Datei. So entstehen keine Duplikate.

## Sicherheitsnetz

- Vor dem Speichern zeigt eine **Vorschau** jede Änderung (neu / ersetzt / bleibt). Danach überschreibt die App immer **dieselbe XML-Datei** (Chrome/Edge).
- Jeder Pfad muss in der geladenen Collection stehen, und alle deine vorhandenen Cues müssen in der Datei sein – sonst bricht der Export ab.
- Jede Cue wird **geprüft** (im Track, A ≤ F < G, Loop mit Länge), die fertige XML wird noch einmal **selbst eingelesen und kontrolliert**.
- Tracks mit **unsicherer Erkennung** werden erst nach deiner Bestätigung (`C`) verändert.
- Tracks mit **Fehlern** (Datei fehlt, nicht lesbar, kein Beatgrid, zu lang) werden nie verändert.
- Vorhandene Hot Cues bleiben standardmäßig erhalten. Rückgängig mit `⌘Z`, Wiederholen mit `⇧⌘Z`.

**Trotzdem: vor jedem Import ein Backup der rekordbox-Library machen** und beim ersten Mal mit 2–3 Tracks testen.

## Hinweise

- Empfohlen: Chrome oder Edge am Desktop. Safari und Firefox gehen mit Einschränkungen (Datei von Hand ersetzen), am Handy lassen sich XML und einzelne Dateien laden.
- Die Energie-Bewertung ist eine Heuristik. Im Zweifel zählt dein Ohr – eigener Wert per Klick.
- **MP3-Versatz:** rekordbox zählt das Encoder-Delay mit, der Browser schneidet es ab (25 oder 51 ms). Die App misst den Versatz pro Track und rechnet ihn bei Analyse und Wiedergabe ein. Geschriebene Cues stehen immer in rekordbox-Zeit.
- **Active Loops:** Das rekordbox-XML hat dafür kein Feld. Auf dem Stick setzt die App die Markierung in den ANLZ-Dateien (mit Sicherung und Rücklesen), in der Sammlung schaltest du sie selbst.
- Serato-Cues: aktuell nur MP3. Vorhandene Serato-Cues bleiben erhalten (außer „überschreiben“ ist an). Bei MP3s kann es zwischen rekordbox und Serato einen minimalen Zeitversatz geben – beim ersten Mal einen Cue in Serato gegenprüfen.

## Entwicklung

Live: https://jamieriedel.com/JAILR-Prep/ (Ordner `JAILR-Prep/` im Repo jamieriedel-website). `python3 src/build.py` baut die App aus `src/src.html` nach `dist/index.html` und die Umzugsseite der alten Adresse nach `index.html`: bettet die Schrift ein und setzt den CSP-Hash des Skripts.
Schrift: Space Grotesk (SIL Open Font License).

Made by JAILR.
