import 'dart:io';
import 'package:isar/isar.dart';
import 'package:biofit_pro/data/models/social_models.dart';
import 'package:path/path.dart' as p;

void main() async {
  // Try common paths for Isar on Windows
  final userProfile = Platform.environment['USERPROFILE'] ?? '';
  final localAppData = Platform.environment['LOCALAPPDATA'] ?? '';
  final appData = Platform.environment['APPDATA'] ?? '';
  
  final possiblePaths = [
    p.join(appData, 'biofit_pro_app', 'biofit_pro_db'),
    p.join(localAppData, 'biofit_pro_app', 'biofit_pro_db'),
    p.join(userProfile, 'Documents', 'biofit_pro_db'),
    // These are common for Flutter Windows apps
    p.join(localAppData, 'com.example', 'biofit_pro', 'biofit_pro_db'),
    p.join(appData, 'com.example', 'biofit_pro', 'biofit_pro_db'),
    p.join(localAppData, 'biofit_pro', 'biofit_pro_db'),
    p.join(appData, 'biofit_pro', 'biofit_pro_db'),
    // Relative to execution if needed
    'biofit_pro_db',
  ];

  for (var path in possiblePaths) {
    if (await Directory(path).exists()) {
      print('FOUND DB at: $path');
      try {
        final isar = await Isar.open(
          [SocialConversationSchema, SocialMessageSchema],
          directory: path,
          name: 'isar_${DateTime.now().millisecond}', // use a temp name to avoid lock if app is running
        );
        
        final msgs = await isar.socialMessages
            .filter()
            .conversationIdEqualTo('dev_support')
            .sortByTimestampDesc()
            .findAll();
            
        print('\n--- BUG REPORTS IN ISAR ---');
        final StringBuffer buffer = StringBuffer();
        buffer.writeln('BIOFIT PRO - ALL INCOMING BUG REPORTS');
        buffer.writeln('======================================\n');
        
        for (var m in msgs) {
          final line = '[${m.timestamp}] ${m.senderName}: ${m.text}';
          print(line);
          buffer.writeln(line);
        }
        
        // CREATE THE TXT FILE
        final reportFile = File('bug_reports.txt');
        await reportFile.writeAsString(buffer.toString());
        print('\nSUCCESS: Reports exported to ${reportFile.absolute.path}');
        
        await isar.close();
        return;
      } catch (e) {
        print('Could not open db at $path: $e');
      }
    }
  }
  print('Could not find any Isar database in common locations.');
}
