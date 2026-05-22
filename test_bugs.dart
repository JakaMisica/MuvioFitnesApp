import 'package:biofit_pro/data/datasources/isar_service.dart';
import 'package:biofit_pro/data/repositories/social_repository.dart';
import 'package:biofit_pro/locator.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  final repo = locator<SocialRepository>();
  final msgs = await repo.getMessagesForConversation('dev_support');
  print('BUG REPORTS FROM ISAR:');
  for (var m in msgs) {
    print('[${m.timestamp}] ${m.senderName}: ${m.text}');
  }
}
