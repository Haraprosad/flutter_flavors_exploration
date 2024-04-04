[⬅️Back](../README.md)

<span style="color:purple;font-size:1.8em; font-weight:bold;">App icon change</span>

***

### Step 1: Add flutter_launcher_icons to pubspec.yaml

```bash
flutter pub add --dev flutter_launcher_icons
```

### Step 2 : Create flutter launcher icons configuration files for specific flavors

Create a Flutter Launcher Icons configuration file for your flavor. The config file is called flutter_launcher_icons-{flavor}.yaml by replacing {flavor} by the name of your desired flavor.

#### flutter_launcher_icons-development.yaml

```dart
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/images/dev_logo.jpg"

```

#### flutter_launcher_icons-staging.yaml

```dart
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/images/stag_logo.png"

```

#### flutter_launcher_icons-production.yaml

```dart
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/images/prod_logo.jpg"

```

### Step 3: Generate icons for specific flavors

#### For Development Flavor  

```bash
flutter pub run flutter_launcher_icons -f flutter_launcher_icons-development.yaml
```

#### For Staging Flavor 

```bash
flutter pub run flutter_launcher_icons -f flutter_launcher_icons-staging.yaml
```

#### For Production Flavor  

```bash
flutter pub run flutter_launcher_icons -f flutter_launcher_icons-production.yaml
```

### Step 4: Run the App

Use the following command to run the app with the specified flavor and the app name will be showed according to flavor specific app name:

```bash
flutter run --flavor {flavor_name} lib/flavors/main_{flavor_name}.dart
```

For example, to run the staging flavor:

```bash
flutter run --flavor staging lib/flavors/main_staging.dart
```

***