import 'package:cheetah/database.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

void generateCrudRoutes(
    Router router, String modelName, Map<String, dynamic> schema) {
  router.post('/$modelName', (Request request) async {
    return await createItem(modelName, await request.readAsString());
  });

  router.get('/$modelName', (Request request) async {
    return await getAllItems(modelName);
  });

  router.get('/$modelName/<id>', (Request request) async {
    final id = request.params['id']!;
    return await getItemById(modelName, id);
  });

  router.put('/$modelName/<id>', (Request request) async {
    final id = request.params['id']!;
    return await updateItem(modelName, id, await request.readAsString());
  });

  router.delete('/$modelName/<id>', (Request request) async {
    final id = request.params['id']!;
    return await deleteItem(modelName, id);
  });
}

Future<Response> createItem(String modelName, String data) async {
  await saveToDatabase(modelName, data);
  return Response.ok('Created $modelName');
}

Future<Response> getAllItems(String modelName) async {
  var items = await getFromDatabase(modelName);
  return Response.ok(items);
}

Future<Response> getItemById(String modelName, String id) async {
  var item = await getFromDatabaseById(modelName, id);
  return Response.ok(item);
}

Future<Response> updateItem(String modelName, String id, String data) async {
  await updateInDatabase(modelName, id, data);
  return Response.ok('Updated $modelName');
}

Future<Response> deleteItem(String modelName, String id) async {
  await deleteFromDatabase(modelName, id);
  return Response.ok('Deleted $modelName');
}
