import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer';

class UserGuard {

  Future<void> store(String token) async {
    const storage = FlutterSecureStorage();
    return await storage.write(key: 'token', value: token);
  }

  Future<bool> has() async {
    const storage = FlutterSecureStorage();
    return await storage.containsKey(key: 'token');
  }

  Future<String?> get() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }

  Future<void> clear() async {
    const storage = FlutterSecureStorage();
    return storage.delete(key: 'token');
  }
}