# CV Flutter Amani (`cv_flutter_amani`)

Application Flutter multi-plateforme (Web / Mobile) intégrant un CV personnel, une page de contact et la gestion complète (CRUD) des membres de famille connectée à une API REST locale (`api-test`) sous XAMPP / MySQL.

## Fonctionnalités
- **Authentification réelle** via l'API (`account`) avec le compte de test (`amani@test.com`).
- **Page CV** avec informations personnelles et photos locales (`assets/images/`).
- **CRUD complet `famille_membre`** (`GET`, `POST`, `PUT`, `DELETE`) sur `http://localhost/api-test/public/famille-membres`, incluant l'enregistrement et l'affichage des photos locales.

## Environnement & Exécution
1. Démarrer **Apache** et **MySQL** dans **XAMPP** (`C:\xampp`) avec la base de données `api` et le projet `api-test` dans `htdocs`.
2. Lancer l'application Flutter depuis le dossier `cv_flutter_amani` :
   ```bash
   flutter pub get
   flutter run -d edge 
   ```
   ## Vidéo de démonstration
- [Voir la vidéo de démonstration sur Google Drive](https://drive.google.com/file/d/18UodOAHqrkVPr-UwkqU8BskRsShv0qdY/view?usp=sharing)