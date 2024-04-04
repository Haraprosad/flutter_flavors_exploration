[⬅️Back](../README.md)

<span style="color:purple;font-size:1.8em; font-weight:bold;">1.File Structure & Basic setup</span>

***
This guide will walk you through the process of setting up flavors in a Flutter app.

### Step 1: File Structure

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
│
├── lib
│   ├── core
│   │   └── constants
│   │       └── string_constants.dart
│   ├── features
│   ├── flavors
│   │   ├── env_config.dart
│   │   ├── environment.dart
│   │   ├── main_development
│   │   ├── main_staging
│   │   └── main_production
│   └── main.dart
│
├── .env.development
├── .env.staging
└── .env.production

```

### Step 2: Create Environment Enum (lib/flavors/environment.dart)

Create an enum providing all environment names you want to support. This enum will help manage different configurations for each environment.

```dart
enum Environment { DEVELOPMENT, STAGING, PRODUCTION }
```

### Step 3: Create Environment Configuration Class (lib/flavors/env_config.dart) 

To cater to various requirements such as URL endpoints, secret keys, themes, and logging criteria, you can configure the EnvConfig file according to your specific needs. In this guide, we focus on essential configurations such as the base URL, application name (for internal display purposes), and environment type (facilitating easy access to the environment name within the application).

```dart
import 'environment.dart';

class EnvConfig {
  late final String appName;
  late final String baseUrl;
  late final Environment environment;

  EnvConfig._internal();
  static final EnvConfig instance = EnvConfig._internal();

  bool _lock = false;
  factory EnvConfig.instantiate({
    required String appName,
    required String baseUrl,
    required Environment environment,
  }) {
    if (instance._lock) return instance;

    instance.appName = appName;
    instance.baseUrl = baseUrl;
    instance.environment = environment;
    instance._lock = true;
    
    return instance;
  }
}

```

### Step 4: Install flutter_dotenv Package

For handling secret keys and URLs in a more secure way, add the flutter_dotenv package to your project.

```bash
flutter pub add flutter_dotenv
```

### Step 5: Configure Environment Variables

Create separate .env files for each flavor containing configuration variables such as base URLs and secret keys.

#### .env.development

```bash
# API configuration
BASE_URL=https://api-dev.example.com
```

#### .env.staging

```bash
# API configuration
BASE_URL=https://api-stag.example.com
```

#### .env.production

```bash
# API configuration
BASE_URL=https://api-prod.example.com
```

### Step 6: Include .env Files in pubspec.yaml

Locate all .env files in pubspec.yaml to include them in the build process.

```bash
flutter:
  assets:
    - .env.development
    - .env.production
    - .env.staging

```

### Step 7: Define String Constants

To avoid hardcoding strings, define required strings in a constants file.

```dart
class StringConstants {

  //Flavors related constants
  static const String envDevelopment = ".env.development";
  static const String envProduction = ".env.production";
  static const String envStaging = ".env.staging";
  static const String envKeyBaseUrl = "BASE_URL";
}

```

### Step 8: Flavor-Specific Main Files

Create separate main.dart files for each flavor to configure environment variables and run the app accordingly.

Common main.dart file for all flavors :

#### lib/main.dart 

```dart
import 'package:flutter/material.dart';

Future<void> runMainApp() async{
  runApp(const MyApp());
}

```

#### lib/flavors/main_development.dart

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../core/constants/string_constants.dart';
import '../main.dart';
import 'env_config.dart';
import 'environment.dart';

void main() async{
  await dotenv.load(fileName: StringConstants.envDevelopment);
  
  EnvConfig.instantiate(
    appName: 'Development App', 
    baseUrl: dotenv.env[StringConstants.envKeyBaseUrl]!, 
    environment: Environment.DEVELOPMENT  
  );

  await runMainApp();
}

```

#### lib/flavors/main_staging.dart 

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../core/constants/string_constants.dart';
import '../main.dart';
import 'env_config.dart';
import 'environment.dart';

void main() async{
  await dotenv.load(fileName: StringConstants.envStaging);
  
  EnvConfig.instantiate(
    appName: 'Staging App', 
    baseUrl: dotenv.env[StringConstants.envKeyBaseUrl]!, 
    environment: Environment.STAGING  
  );

  await runMainApp();
}

```

#### lib/flavors/main_production.dart 

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../core/constants/string_constants.dart';
import '../main.dart';
import 'env_config.dart';
import 'environment.dart';

void main() async{
  await dotenv.load(fileName: StringConstants.envProduction);
  
  EnvConfig.instantiate(
    appName: 'Production App', 
    baseUrl: dotenv.env[StringConstants.envKeyBaseUrl]!, 
    environment: Environment.PRODUCTION 
  );

  await runMainApp();
}

```

### Step 9: Access Environment Configuration

```dart
 @override
  Widget build(BuildContext context) {
  final EnvConfig envConfig = EnvConfig.instance;
    var baseUrl = envConfig.baseUrl;
    var appName = envConfig.appName
    //*************rest part************** */
  }

```

### Step 10: Configuring Android Flavor-Specific Settings in build.gradle

To execute the application according to specified flavors and enable capabilities such as adjusting the application name and icons based on the flavors, additional configurations are required in the android/app/build.gradle file for Android.

```dart
buildTypes {
//*********************** */
    }

    flavorDimensions "app"

    productFlavors {
        production {
            dimension "app"
        }
        development {
            dimension "app"
            applicationIdSuffix ".dev"
        }
        staging {
            dimension "app"
            applicationIdSuffix ".stag"
        }
    }

```

### Step 11: Run the App

Use the following command to run the app with the specified flavor:

```bash
flutter run --flavor {flavor_name} lib/flavors/main_{flavor_name}.dart
```

For example, to run the staging flavor:

```bash
flutter run --flavor staging lib/flavors/main_staging.dart
```

### Step 12: To run the app directly with run button, set flavors configuration in ide. I am providing here only vs code configuration.

N:B: To run IOS app xcode flavors specific configuration is needed. (You can follow the following blog for that.)

[IDE configuration](https://www.binaryveda.com/blog/flavours-setup-in-flutter)

Vs code configuration: (launch.json)

```bash
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "development",
            "request": "launch",
            "type": "dart",
            "program": "lib/flavors/main_development.dart",
            "args": ["--flavor", "development", "target", "lib/flavors/main_development.dart"]
        },
        {
            "name": "production",
            "request": "launch",
            "type": "dart",
            "program": "lib/flavors/main_production.dart",
            "args": ["--flavor", "production", "target", "lib/flavors/main_production.dart"]
        },
        {
            "name": "staging",
            "request": "launch",
            "type": "dart",
            "program": "lib/flavors/main_staging.dart",
            "args": ["--flavor", "staging", "target", "lib/flavors/main_staging.dart"]
        },
    ]
}
```

***