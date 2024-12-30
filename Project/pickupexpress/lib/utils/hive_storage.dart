import 'package:hive/hive.dart';

Future<void> storeUserId(String userId) async {
  var box = await Hive.openBox('userBox');
  await box.put('userId', userId);
}

Future<String?> getUserId() async {
  var box = await Hive.openBox('userBox');
  return box.get('userId');
}
