import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Db? db;

Future<void> initDatabase(String url, String dbName) async {
  db = await Db.create(url);
  await db!.open();
}

Future<Map<String, dynamic>> saveToDatabase(
    String collectionName, String data) async {
  DbCollection collection = db!.collection(collectionName);

  Map<String, dynamic> parsedData = jsonDecode(data);

  WriteResult result = await collection.insertOne(parsedData);
  return result.document!;
}

Future<List<Map<String, dynamic>>> getFromDatabase(
    String collectionName) async {
  var collection = db!.collection(collectionName);
  var result = await collection.find().toList();
  return result;
}

Future<Map<String, dynamic>> getFromDatabaseById(
    String collectionName, String id) async {
  var collection = db!.collection(collectionName);
  var result = await collection.findOne(where.id(ObjectId.fromHexString(id)));
  return result!;
}

Future<void> updateInDatabase(
    String collectionName, String id, String data) async {
  var collection = db!.collection(collectionName);
  await collection.update(
      where.id(ObjectId.fromHexString(id)), modify.set('data', data));
}

Future<void> deleteFromDatabase(String collectionName, String id) async {
  var collection = db!.collection(collectionName);
  await collection.remove(where.id(ObjectId.fromHexString(id)));
}
