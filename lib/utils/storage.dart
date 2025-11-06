import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterStorage{

  final storage = FlutterSecureStorage();

  Future writeStorage( String key,String value) async{
    await storage.write(key: key, value: value);
  }

  Future readStorage(String key) async{
    final storageContent = await storage.read(key: key);
    return storageContent;
  }

  Future deleteStorage() async{
    await storage.deleteAll();
  }

}