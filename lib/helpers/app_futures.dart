import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:iiserk_app/models/lms_category.dart';
import 'package:iiserk_app/models/Token.dart';
import 'package:iiserk_app/models/User.dart';
import 'package:iiserk_app/models/base/EventObject.dart';
import 'package:iiserk_app/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<EventObject> getTokenByLogin(String username, String password) async {
  Uri currentUrl =
      Uri.parse(APIConstants.API_BASE_URL + APIOperations.getTokenByLogin);

  try {
    final response = await http
        .post(currentUrl, body: {'username': username, 'password': password});
    print(currentUrl);
    print(response.body.toString());

    if (response.statusCode == APIResponseCode.SC_OK &&
        response.body.isNotEmpty) {
      final responseJson = json.decode(response.body);
      Token result = Token.fromJson(responseJson);
      //print("Token: " + result.token);
      if (result.token.isNotEmpty)
        return new EventObject(
            id: EventConstants.LOGIN_USER_SUCCESSFUL, object: result.token);
      else
        return new EventObject(id: EventConstants.LOGIN_USER_UN_SUCCESSFUL);
    } else
      return new EventObject(id: EventConstants.LOGIN_USER_UN_SUCCESSFUL);
  } catch (Exception) {
    return EventObject();
  }
}

Future<EventObject> fetchUserDetail(String token) async {
  Uri currentUrl = Uri.parse(APIConstants.API_BASE_URL +
      APIOperations.fetchUserDetail +
      '&wstoken=' +
      token);

  try {
    final response = await http.get(currentUrl);
    print(currentUrl);
    print(response.body.toString());

    if (response.statusCode == APIResponseCode.SC_OK &&
        response.body.isNotEmpty) {
      final responseJson = json.decode(response.body);
      User user = User.fromJson(responseJson);
      if (user.firstname.isNotEmpty)
        return new EventObject(
            id: EventConstants.LOGIN_USER_SUCCESSFUL, object: user);
      else
        return new EventObject(id: EventConstants.LOGIN_USER_UN_SUCCESSFUL);
    } else
      return new EventObject(id: EventConstants.LOGIN_USER_UN_SUCCESSFUL);
  } catch (Exception) {
    return EventObject();
  }
}

Future<EventObject> registerUser(
    String name, String emailId, String password) async {
  return EventObject();
}

Future<EventObject> changePassword(
    String emailId, String oldPassword, String newPassword) async {
  return EventObject();
}

List<LmsCategory> parseCats(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<LmsCategory>((json) => LmsCategory.fromJson(json)).toList();
}

Future<List<LmsCategory>> fetchCats(String responseBody) async {
  return compute(parseCats, responseBody);
}

Future<EventObject> fetchCategories(String token) async {
  Uri currentUrl = Uri.parse(APIConstants.API_BASE_URL +
      APIOperations.getCourses +
      '&wstoken=' +
      token);
  try {
    final response = await http.get(currentUrl);
    print(currentUrl);
    print(response.body.toString());

/*
    if (response.statusCode == APIResponseCode.SC_OK && response.body.isNotEmpty) {
      List<LmsCategory> categories = await fetchCats(response.body);
      if (categories.isNotEmpty)
        return new EventObject(
            id: EventConstants.REQUEST_UN_SUCCESSFUL, object: categories);
      else
        return new EventObject(id: EventConstants.REQUEST_UN_SUCCESSFUL);
    } else
      return new EventObject(id: EventConstants.REQUEST_UN_SUCCESSFUL);
*/
    return new EventObject();
  } catch (Exception) {
    return EventObject();
  }
}

Future<EventObject> fetchCourses(String token) async {
  Uri currentUrl = Uri.parse(APIConstants.API_BASE_URL +
      APIOperations.getCourses +
      '&wstoken=' +
      token);

  try {
    final response = await http.get(currentUrl);

    if (response.statusCode == APIResponseCode.SC_OK &&
        response.body.isNotEmpty) {
      List<LmsCategory> categories = await fetchCats(response.body);
      if (categories.isNotEmpty)
        return new EventObject(
            id: EventConstants.REQUEST_UN_SUCCESSFUL, object: categories);
      else
        return new EventObject(id: EventConstants.REQUEST_UN_SUCCESSFUL);
    } else
      return new EventObject(id: EventConstants.REQUEST_UN_SUCCESSFUL);
  } catch (Exception) {
    return EventObject();
  }
}
