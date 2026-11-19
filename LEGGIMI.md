# Datalogger 9 assi - app Flutter per FlutLab

App Android (Flutter) che si collega via Bluetooth al sensore costruito e mostra anche i due WitMotion WT9011DCL
(che il sensore legge e inoltra). Non dipende da Claude.

## Funzioni
- Scheda Sensore: temperatura, pressione, batteria %, quota relativa, stato microSD, avvio/stop registrazione,
  grafici di accelerazione, giroscopio, magnetometro, orientamento, temperatura, pressione, quota, vibrazione RMS e
  frequenza dominante, avviso urti.
- Schede WT1 e WT2: accelerazione, giroscopio, angoli, con valori e grafici.
- Scheda Strumenti: orologio, calibrazioni, parametri (fondo scala, frequenza, soglia urto), dimentica sensori WT,
  elenco e download dei file sulla microSD, registrazione sul telefono con condivisione del CSV.
- Non ci sono (rispetto alla versione web): zoom a pizzico, cursore e elenco delle sessioni salvate.

## Collegamento diretto ai WitMotion (senza il sensore costruito)
- Il pulsante "WT diretto" in alto cerca i sensori WitMotion (nome che inizia per "WT" o servizio ffe5) e collega i primi due.
- I dati compaiono nelle schede WT1 e WT2 con valori e grafici in tempo reale.
- Sotto lo stato "connesso" la scheda mostra quanti pacchetti sono arrivati e l'ultimo pacchetto in esadecimale:
  serve per capire se i dati arrivano e in che formato.
- Il pulsante "Connetti" invece collega il sensore costruito, che inoltra anche i WitMotion.
- Formati letti: 0x55 0x61 (20 byte) dei sensori Bluetooth 5.0 e 0x55 0x51/0x52/0x53 (11 byte) dei modelli piu' vecchi.

## Costruire l'APK su GitHub (alternativa a FlutLab, gratuita)
1. Crea un account su github.com e un nuovo repository.
2. Carica nella radice del repository: pubspec.yaml, la cartella lib e la cartella .github (con dentro workflows/build-apk.yml).
   Le cartelle che iniziano con il punto a volte non si caricano trascinandole: in quel caso usa "Add file > Create new file",
   scrivi come nome .github/workflows/build-apk.yml e incolla il contenuto del file.
3. Scheda Actions, "Costruisci APK Flutter", Run workflow. Aspetta qualche minuto.
4. Apri l'esecuzione completata e scarica l'artefatto "Datalogger9-apk" (e' uno zip con app-release.apk).
5. Copia l'APK sul telefono e installalo (consenti le app da fonti sconosciute).
Il flusso genera da solo la cartella android e aggiunge i permessi Bluetooth: non servono altri passaggi.
Non l'ho potuto provare. Se il flusso da' errore, copia il messaggio dalla pagina Actions e mandamelo.

## Come usarla in FlutLab
1. Accedi a flutlab.io e crea un nuovo progetto Flutter (oppure usa l'importazione di un progetto).
2. Sostituisci il contenuto di pubspec.yaml con quello di questo pacchetto e di lib/main.dart con il file main.dart.
3. Apri android/app/src/main/AndroidManifest.xml e incolla, dentro <manifest> e prima di <application>:

   <uses-permission android:name="android.permission.BLUETOOTH" android:maxSdkVersion="30" />
   <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" android:maxSdkVersion="30" />
   <uses-permission android:name="android.permission.BLUETOOTH_SCAN" android:usesPermissionFlags="neverForLocation" />
   <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
   <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" android:maxSdkVersion="30" />
   <uses-feature android:name="android.hardware.bluetooth_le" android:required="true" />

4. In android/app/build.gradle controlla che minSdkVersion sia almeno 21.
5. Esegui "pub get" (di solito automatico) e poi la compilazione dell'APK Android.
6. Scarica l'APK, copialo sul telefono e installalo (consenti le app da fonti sconosciute). Puoi inviarlo ad altri
   telefoni Android.

## Attenzione
- L'anteprima nel browser di FlutLab non ha il Bluetooth: prova l'app sul telefono con l'APK.
- Non ho potuto compilare questo codice: potrebbero comparire errori di versione dei pacchetti (flutter_blue_plus,
  share_plus, path_provider) legati alla versione di Flutter di FlutLab. Se succede, copia gli errori e la versione
  di Flutter/Dart che FlutLab mostra: adatto il progetto.
- Piano gratuito di FlutLab: ha dei limiti; controlla sul loro sito se la compilazione dell'APK e' inclusa.
- Il sensore deve avere il firmware aggiornato (pacchetto da 148 byte). Il protocollo e' lo stesso dell'app web.
- iPhone: servirebbe una compilazione iOS (Mac e account sviluppatore Apple), non e' compresa qui.
