import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/helpers/server_helper.dart';
import 'dart:convert';

class NetworkService with ChangeNotifier {
  NetworkService();

  Future<HandlingServerLog> doHttpGet(url) async {
    dynamic header;
    {
      header = {
        'Content-Type': 'application/json',
      };
    }

    http.Response response = await http.get(
      Uri.parse("${Constant.tmdbBaseUrl}$url"),
      headers: header,
    );

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

    {
      header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
    }

    http.Response response = await http.post(
      Uri.parse("${Constant.tmdbBaseUrl}$url"),
      body: requestBody,
      headers: header,
    );

    var resBody = json.decode(response.body);
    return HandlingServerLog(
      resBody['status_code'],
      resBody,
      resBody['status_message'],
      resBody['success'],
    );
  }

  Future<HandlingServerLog> doHttpDelete(url, reqBody) async {
    dynamic header;
    var requestBody = json.encode(reqBody);

    {
      header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
    }

    http.Response response = await http.delete(
      Uri.parse("${Constant.tmdbBaseUrl}$url"),
      headers: header,
      body: requestBody,
    );

    var resBody = json.decode(response.body);
    return HandlingServerLog(
      resBody['status_code'],
      resBody,
      resBody['status_message'],
      resBody['success'],
    );
  }
}
