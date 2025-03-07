# Cheetah Framework 🐆

A simple, dynamic, and fast Dart framework for building RESTful APIs with auto-generated CRUD endpoints based on your domain models. With Cheetah, you can quickly define your models and have the framework automatically generate all CRUD operations for them.

## Features 🚀

- **Dynamic CRUD generation** for models.
- **Middleware support** to handle custom logic.
- **Built-in error handling**.
- **MongoDB integration** for easy database interactions.
- **Hot reloading** for fast development.

## Installation 🔧

1. Clone this repository or add it as a dependency in your Dart project.
2. Run the following command to install dependencies:

```bash
dart pub get
```

## Setup and Usage 📦

1. **Create a Dart project** and add `cheetah` as a dependency in `pubspec.yaml`.

2. **Create `bin/cheetah.dart`** to initialize and run the app.

Here’s an example of how to set up a basic API using the Cheetah Framework:

```dart
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

  app.use((req, res, next, [queryParams]) async {
    print('Request: ${req.method} ${req.uri.path}');
    await next();
  });

  app.get('/', (req, res, next) async {
    res
      ..write('Welcome to Cheetah Framework!')
      ..close();
  });

  await app.listen(enableHotReload: true);
}
```

3. **Run the app**:
   To run your server, use the following command:

```bash
dart run bin/cheetah.dart
```

### Example Routes 🚀

Once the server is running, the following routes are automatically available for the models in the `domain`:

- `POST /people` - Create a new person.
- `GET /people` - Get all people.
- `GET /people/:id` - Get a person by ID.
- `PUT /people/:id` - Update a person by ID.
- `DELETE /people/:id` - Delete a person by ID.

Similarly, routes are generated for the `posts` model.

### Query Parameters 🌐

You can pass query parameters in your requests like so:

- `/search?q=keyword` - Example of how query parameters work.
  
The `q` parameter can be accessed inside the route handlers.

### Error Handling 🛠

By default, Cheetah includes a basic error handler:

```dart
app.setErrorHandler((req, res, next, [queryParams]) async {
  res
    ..statusCode = 500
    ..write('Oops! Something went wrong.')
    ..close();
});
```

This will return a `500` status code if something goes wrong in your app.

### Database Integration 🔒

Cheetah uses MongoDB for storage. To connect to the database:

- Make sure MongoDB is running locally or on a remote server.
- Specify the database URL and name in the `Cheetah` constructor.

The framework will handle database interactions for creating, reading, updating, and deleting data in the specified collections (`people`, `posts`, etc.).

## Middleware 🛠

You can define custom middleware to process requests before they reach the route handlers:

```dart
app.use((req, res, next) async {
  print('Logging request: ${req.method} ${req.uri.path}');
  await next();
});
```

Middleware is executed in the order it's defined. You can also handle things like authentication, logging, or any custom functionality.

## Hot Reload ⚡️

Cheetah supports hot reloading during development, so you don't need to restart the server every time you make changes.

Simply start the server with `await app.listen(enableHotReload: true);` and the changes will automatically apply without stopping the server.

## Contributing 💻

We welcome contributions! Please fork the repository, create a new branch, and submit a pull request with your changes.

1. Fork this repository
2. Create a new branch (`git checkout -b feature-name`)
3. Commit your changes (`git commit -am 'Add feature'`)
4. Push to the branch (`git push origin feature-name`)
5. Create a new pull request

## License 📝

Cheetah is open-source software licensed under the MIT License. See the LICENSE file for details.
