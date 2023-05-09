import 'dart:convert';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

// ignore: constant_identifier_names
enum RequestMethod { GET, POST, PATCH, DELETE, PUT }

const String itunesUrl = 'https://itunes.apple.com/';

@injectable
class Api {
  final Client _client;

  Api(this._client);

  Future<Response> apiRequest({
    required String url,
    required RequestMethod method,
    required String apiPath,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameter,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(
      generateUrl(url: url, path: apiPath, params: queryParameter),
    );

    try {
      Response response;
      switch (method) {
        case RequestMethod.GET:
          response = await _client.get(uri, headers: headers);
          break;
        case RequestMethod.DELETE:
          response = await _client.delete(uri, headers: headers);
          break;
        case RequestMethod.POST:
          response = await _client.post(
            uri,
            headers: headers,
            body: jsonEncode(body),
          );
          break;
        case RequestMethod.PATCH:
          response = await _client.patch(
            uri,
            headers: headers,
            body: jsonEncode(body),
          );
          break;
        case RequestMethod.PUT:
          response = await _client.put(
            uri,
            headers: headers,
            body: jsonEncode(body),
          );
          break;
      }
      return response;
    } catch (e) {
      return Response(
        jsonEncode({
          "url": uri.path,
          "error": e,
          "request": body,
          "headers": headers,
          "method": method
        }),
        505,
      );
    }
  }

  String generateUrl({
    required String url,
    Map<String, dynamic>? params,
    String? path,
  }) {
    if (params == null) return url + (path ?? '');
    List queryString = [];
    params.forEach((key, value) {
      if (value != null) {
        queryString.add('$key=$value');
      }
    });
    String queryPath = queryString.join('&');
    return url + (path != null ? "$path?" : "") + queryPath;
  }
}
