# SmartDine Queue Manager
Flutter Web application for queue manager/ receptionist of restaurant.

## Flutter version
Flutter 3.10.5 • channel stable
Tools • Dart 3.0.5 • DevTools 2.23.1

## Bundle Id (web)
- com.example.smartdine_queue_manager

## Features

- Dashboard : add, delete, search in customer queue. Drag and drop customer to available tables.


## State management
- package : flutter_bloc
- Cubit (clean architecture)

## Dependency injection
- get_it

## Navigation plugin
- fluro

## Build Flavors
- dev
- prod

## Naming Conventions
- Folder Name : your_folder_name
- File Name : your_file_name.dart
- Class Name : YourClassName
- Variable Name :  yourVariableName
- Private Variable Name : _yourPrivateVariableName
- Function Name : yourFunctionName
- Private Function Name : _yourPrivateFunctionName


## Themes (Light & Dark)

Define theme in ‘lib/core/theme/smartdine_theme.dart’

## Localization guide :
https://www.codeandweb.com/babeledit/tutorials/how-to-translate-your-flutter-apps

## Architecture

- For the SmartDine flutter web project, we are following a clean architecture as a project structure:

1) Core
    - With core folders and files that are to be utilized all over the project

2) Features
    - Individual feature folder with clean architectural structure with data, domain and presentation layers including
      their dependency injections.


## Directory Structure

```
├── smartdine_queue_manager
│    ├── assets
│    │   ├── fonts
│    │   ├── images
│    ├── lib
│    │   ├── core
│    │   │   ├── base
│    │   │   ├── database
│    │   │   ├── enums
│    │   │   ├── extensions
│    │   │   ├── failure
│    │   │   ├── helpers
│    │   │   ├── localization
│    │   │   ├── navigation
│    │   │   ├── responsive
│    │   │   ├── services
│    │   │   ├── theme
│    │   │   ├── utils
│    │   │   ├── widgets
│    │   │   ├── core.dart
│    │   ├── features
│    │   │   ├── feature_name
│    │   │   │   ├── data
│    │   │   │   │   ├── datasources
│    │   │   │   │   ├── models
│    │   │   │   │   └── repository_impl
│    │   │   │   ├── domain
│    │   │   │   │   ├── repository
│    │   │   │   │   └── usecases
│    │   │   │   ├── presentation
│    │   │   │   │   ├── Cubit
│    │   │   │   │   ├── pages
│    │   │   │   │   └── widgets
│    │   │   │   └── feature_name_dependency_injection.dart
│    │   ├── l10n
│    │   ├── ├── app_en.arb
│    │   ├── ├── app_fr.arb
│    │   ├── main.dart
│    ├── pubspec.lock
│    ├── pubspec.yaml
│    ├── README.md
```


## To generate files
flutter packages pub run build_runner build --delete-conflicting-outputs


## Supported browsers
tested on Chrome, Firefox, Safari with latest versions.

## How to Run the app

Run the below command in terminal:

- flutter clean
- flutter pub get
- flutter packages pub run build_runner build --delete-conflicting-outputs

1) Development build:
- change env variable name to DEV in main.dart
- flutter run -d chrome --release -t lib/main.dart


2) Production build:
- change env variable name to PROD in main.dart
- flutter run -d chrome --release -t lib/main.dart