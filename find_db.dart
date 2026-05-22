import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() async {
  try {
    final supportDir = await getApplicationSupportDirectory();
    final localDir = await getApplicationCacheDirectory();
    final docsDir = await getApplicationDocumentsDirectory();
    
    print('--- FINDING DB ---');
    print('Support: ${supportDir.path}');
    print('Cache: ${localDir.path}');
    print('Docs: ${docsDir.path}');
    
    final dbPath = Directory('${supportDir.path}/biofit_pro_db');
    if (await dbPath.exists()) {
      print('FOUND! -> ${dbPath.path}');
    } else {
      print('NOT FOUND matching path_provider location.');
      // List contents of supportDir
      print('Listing support dir:');
      if (await supportDir.exists()) {
        await for (var item in supportDir.list()) {
          print(' - ${item.path}');
        }
      }
    }
  } catch (e) {
    print('Error: $e');
  }
}
