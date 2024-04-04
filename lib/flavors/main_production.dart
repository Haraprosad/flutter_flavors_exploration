import 'package:flutter_flavors_exploration/core/constants/string_constants.dart';
import 'package:flutter_flavors_exploration/flavors/env_config.dart';
import 'package:flutter_flavors_exploration/flavors/environment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_flavors_exploration/main.dart';

void main() async{
  await dotenv.load(fileName: StringConstants.envProduction);
  
  EnvConfig.instantiate(
    appName: 'Production App', 
    baseUrl: dotenv.env[StringConstants.envKeyBaseUrl]!, 
    environment: Environment.PRODUCTION 
  );

  await runMainApp();
}