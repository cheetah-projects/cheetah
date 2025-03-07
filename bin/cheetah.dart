import 'package:cheetah/cheetah.dart';

void main() async {
  final app = Cheetah(
    dbUrl: 'mongodb://localhost:27017',
    dbName: 'cheetah_db',
    domain: {
      'people': {},
      'posts': {},
    },
  );

  await app.run();
}
