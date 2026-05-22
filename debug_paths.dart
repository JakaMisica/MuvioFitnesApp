import 'dart:io';
import 'package:path_provider_windows/path_provider_windows.dart';

void main() async {
  final provider = PathProviderWindows();
  final appSupport = await provider.getApplicationSupportPath();
  final localAppDir = await provider.getLocalAppDataPath();
  final appDataDir = await provider.getRoamingAppDataPath();
  
  print('--- SYSTEM PATHS ---');
  print('App Support: $appSupport');
  print('Local AppData: $localAppDir');
  print('Roaming AppData: $appDataDir');
}
