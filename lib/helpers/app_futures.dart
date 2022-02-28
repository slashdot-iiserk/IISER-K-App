import 'dart:async';
import 'dart:convert';

import 'package:iiserk_app/models/Token.dart';
import 'package:iiserk_app/models/base/EventObject.dart';
import 'package:iiserk_app/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<EventObject<Token>> getTokenByLogin(
    String username, String password) async {
  Uri currentUrl =
      Uri.parse(APIConstants.API_BASE_URL + APIOperations.getTokenByLogin);

  try {
    final response = await http
        .post(currentUrl, body: {'username': username, 'password': password});
    print(currentUrl);
    print({'username': username, 'password': password});
    print(response.body.toString());

    if (response.statusCode == APIResponseCode.SC_OK &&
        response.body.isNotEmpty) {
      final responseJson = json.decode(response.body);
      Token result = Token.fromJson(responseJson);
      //print("Token: " + result.token);
      if (result.token.isNotEmpty)
        return new EventObject(
            id: EventConstants.LOGIN_USER_SUCCESSFUL, object: result);
      else
        return new EventObject(id: EventConstants.LOGIN_USER_UN_SUCCESSFUL);
    } else
      return new EventObject(id: EventConstants.LOGIN_USER_UN_SUCCESSFUL);
  } catch (exception) {
    return EventObject();
  }
}
