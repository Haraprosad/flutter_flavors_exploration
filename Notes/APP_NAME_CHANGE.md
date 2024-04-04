[⬅️Back](../README.md)

<span style="color:purple;font-size:1.8em; font-weight:bold;">App name change</span>

***

### Step 1: Specify app name for specific flavors

In the `lib/android/app/src/{flavor_name}/res/values/` directory, create flavor-specific `strings.xml` files to specify the app name for each flavor.

```bash
flutter_app_name
│
├── android
│   ├── app
│   │   └── src
│   │       ├── development
│   │       │   └── res
│   │       │       └── values
│   │       │           └── strings.xml
│   │       ├── staging
│   │       │   └── res
│   │       │       └── values
│   │       │           └── strings.xml
│   │       └── production
│   │           └── res
│   │               └── values
│   │                   └── strings.xml

```

### Flavor-Specific App Name

#### Development Flavor

```bash
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">Dev App</string>
</resources>

```

#### Production Flavor

```bash
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">Prod App</string>
</resources>

```

### Step 2 : Provide app_name path to AndroidManifest.xml file

```bash
<application
        android:label="@string/app_name"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">

```

### Step 3: Run the App

Use the following command to run the app with the specified flavor and the app name will be showed according to flavor specific app name:

```bash
flutter run --flavor {flavor_name} lib/flavors/main_{flavor_name}.dart
```

For example, to run the staging flavor:

```bash
flutter run --flavor staging lib/flavors/main_staging.dart
```

***