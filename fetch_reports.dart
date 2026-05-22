import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void main() async {
  print('--- FETCHING BUG REPORTS FROM CLOUD (REST) ---');
  try {
    final url = Uri.parse('https://firestore.googleapis.com/v1/projects/fitnesapp-d5c3c/databases/(default)/documents/messages?orderBy=timestamp%20desc&pageSize=100');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List documents = data['documents'] ?? [];
      
      final StringBuffer buffer = StringBuffer();
      buffer.writeln('BIOFIT PRO - CLOUD BUG REPORTS');
      buffer.writeln('==============================\n');
      
      int count = 0;
      final cutoff = DateTime.now().subtract(const Duration(days: 30));
      print('Filtering reports after: $cutoff');

      for (var doc in documents) {
        final fields = doc['fields'] ?? {};
        final cid = fields['conversationId']?['stringValue'] ?? '';
        
        if (cid == 'dev_support') {
          final tsStr = fields['timestamp']?['timestampValue'] ?? '';
          if (tsStr.isEmpty) continue;
          
          final ts = DateTime.tryParse(tsStr);
          if (ts == null || ts.isBefore(cutoff)) continue;
          
          final sname = fields['senderName']?['stringValue'] ?? 'User';
          final text = fields['text']?['stringValue'] ?? '';
          
          final line = '[$tsStr] $sname: $text';
          print(line);
          buffer.writeln(line);
          count++;
        }
      }
      
      if (count == 0) {
        print('No reports found in the last 100 messages.');
      } else {
        await File('bug_reports.txt').writeAsString(buffer.toString());
        print('\nSUCCESS: $count reports saved to bug_reports.txt');
      }
    } else {
      print('HTTP ERROR: ${response.statusCode}');
      print(response.body);
    }
  } catch (e) {
    print('Error: $e');
  }
}
