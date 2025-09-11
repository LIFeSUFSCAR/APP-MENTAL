import 'dart:io';

import 'package:app_mental/classes/SensorConfiguration.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class SensorConfigurationDatabase {
  SensorConfigurationDatabase._privateConstructor();
  static final SensorConfigurationDatabase instance =
      SensorConfigurationDatabase._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<String> getUserEmail() async {
    return await HelperFunctions.getUserEmailInSharedPreference();
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'readings.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE sensor_configuration(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          accelerometer INTEGER,
          gyroscope INTEGER,
          location INTEGER,
          userEmail STRING
      )
      ''');
  }

  Future<SensorConfiguration?> getConfiguration(String email) async {
    Database db = await instance.database;
    var sensorConfiguration = await db.query('sensor_configuration',
        where: 'userEmail = ?', whereArgs: [email]);
    print(sensorConfiguration.firstOrNull);
    SensorConfiguration? configuration = (sensorConfiguration.isNotEmpty
        ? SensorConfiguration.fromMap(sensorConfiguration.first)
        : null);
    return configuration;
  }

  Future<int> add(SensorConfiguration configuration) async {
    Database db = await instance.database;
    return await db.insert('sensor_configuration', configuration.toMap());
  }

  Future<int> update(SensorConfiguration configuration) async {
    Database db = await instance.database;
    return await db.update('sensor_configuration', configuration.toMap());
  }
}
