import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/helpers/server_helper.dart';
import 'dart:convert';
import 'package:tmdb_app/services/constant_service.dart';

class NetworkService with ChangeNotifier {
  ConstantService constantService;
  NetworkService(this.constantService);

  Future<HandlingServerLog> doHttpGet(url) async {
    dynamic header;
    if (constantService.token != null) {
      header = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${constantService.token}"
      };
    } else {
      header = {
        'Content-Type': 'application/json',
      };
    }

    http.Response response = await http.get(Uri.parse("${Constant.baseUrl}$url"), headers: header);

    var resBody = json.decode(response.body);
    return HandlingServerLog(
      resBody['status_code'],
      resBody,
      resBody['status_message'],
      resBody['success'],
    );
  }

  Future<HandlingServerLog> doHttpPost(
    String url,
    reqBody,
  ) async {
    var requestBody = json.encode(reqBody);

    dynamic header;

    if (constantService.token != null) {
      header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': "Bearer ${constantService.token}"
      };
    } else {
      header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
    }

    http.Response response =
        await http.post(Uri.parse("${Constant.baseUrl}$url"), body: requestBody, headers: header);

    var resBody = json.decode(response.body);
    return HandlingServerLog(
      resBody['status_code'],
      resBody,
      resBody['status_message'],
      resBody['success'],
    );
  }

  Future<HandlingServerLog> doHttpPut(
    String url,
    reqBody,
  ) async {
    dynamic requestBody;
    if (reqBody == null) {
      requestBody = null;
    }
    if (reqBody != null) {
      requestBody = json.encode(reqBody);
    }

    dynamic header;

    if (constantService.token != null) {
      header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': "Bearer ${constantService.token}"
      };
    } else {
      header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
    }

    http.Response response =
        await http.put(Uri.parse("${Constant.baseUrl}$url"), body: requestBody, headers: header);

    var resBody = json.decode(response.body);
    return HandlingServerLog(
      resBody['status_code'],
      resBody,
      resBody['status_message'],
      resBody['success'],
    );
  }

  Future<HandlingServerLog> doHttpDelete(url) async {
    dynamic header;

    if (constantService.token != null) {
      header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': "Bearer ${constantService.token}"
      };
    } else {
      header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
    }

    http.Response response = await http.delete(Uri.parse("${Constant.baseUrl}$url"), headers: header);

    var resBody = json.decode(response.body);
    return HandlingServerLog(
      resBody['status_code'],
      resBody,
      resBody['status_message'],
      resBody['success'],
    );
  }
}
