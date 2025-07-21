import 'dart:io';
import 'dart:convert'; // for jsonEncode

void main() async {

  // final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
 // FOR DOCKER
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);

  print('Server running on http://${server.address.host}:${server.port}');

  await for (HttpRequest request in server) {
    final params = request.uri.queryParameters;

    print('--- Incoming Request ---');
    print('Path: ${request.uri.path}');
    print('Parameters: $params');

    // Set content type to application/json
    request.response.headers.contentType = ContentType.json;

    // Send JSON response
    request.response
      ..statusCode = HttpStatus.ok
      ..write(jsonEncode({
        'status': 'success',
        'received': params,
      }))
      ..close();
  }
}
