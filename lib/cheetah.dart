import 'dart:io';
import 'package:cheetah/database.dart';
import 'package:cheetah/handler.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

class Cheetah {
  final String dbUrl;
  final String dbName;
  final Map<String, Map<String, dynamic>> domain;

  Cheetah({
    required this.dbUrl,
    required this.dbName,
    required this.domain,
  });

  Future<void> run() async {
    await initDatabase(dbUrl, dbName);

    final router = Router();

    for (String modelName in domain.keys) {
      generateCrudRoutes(router, modelName, domain[modelName]!);
    }

    Handler handler =
        Pipeline().addMiddleware(logRequests()).addHandler(router.call);

    await io.serve(handler, InternetAddress.anyIPv4, 8080);
    print('Server listening on port 8080');
  }
}
