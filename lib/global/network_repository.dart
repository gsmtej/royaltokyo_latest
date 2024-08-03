import 'dart:async';
import 'dart:convert';

import 'package:buyer_app/global/PreferenceHelper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


Future callPostMethod(String url, Map<String, dynamic> params) async {
  printWrapped("params--" + jsonEncode(params));
  printWrapped("baseUrl--" + url);
  return await http.post(
    Uri.parse(url),
    body: utf8.encode(json.encode(params)),
    headers: {'Content-Type': 'application/json', 'accept': '*/*' ,'Cookie': 'PHPSESSID=664123cef63a48ca2cc1ba554f6471d3'},
  ).then((http.Response response) {
    return getResponse(response);
  });
}

Future callDeleteMethod(String url, Map<String, dynamic> params) async {
  printWrapped("params--" + jsonEncode(params));
  printWrapped("baseUrl--" + url);
  return await http.delete(
    Uri.parse(url),
    body: utf8.encode(json.encode(params)),
    headers: {'Content-Type': 'application/json', 'accept': '*/*' ,'Cookie': 'PHPSESSID=4ca1864a5dd59a12e71644d91f8a9daa'},
  ).then((http.Response response) {
    return getResponse(response);
  });
}

Future callGetMethod(String url) async {
  printWrapped("baseUrl--" + url);
  return await http.get(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json', 'accept': '*/*',  'Cookie': 'PHPSESSID=664123cef63a48ca2cc1ba554f6471d3'},
  ).then((http.Response response) {
    return getResponse(response);
  });
}

Future callGetMethodWitAuth(String url) async {
  printWrapped("baseUrl--" + url);
  printWrapped("Authorization --" + 'Bearer ${PreferenceHelper.getString(PreferenceHelper.AUTH_TOKEN)}');
  return await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${PreferenceHelper.getString(PreferenceHelper.AUTH_TOKEN)}' ?? ''
    },
  ).then((http.Response response) {
    return getResponse(response);
  });
}

Future callGetMethodwithParam(String url,Map<String, dynamic> params) async {
  printWrapped("baseUrl--" + url);

  return await http.get(
    Uri.parse(url).replace(queryParameters: params),
    // Uri.parse(url),
    headers: {'Content-Type': 'application/json', 'accept': '*/*',  'Cookie': 'PHPSESSID=664123cef63a48ca2cc1ba554f6471d3'},
  ).then((http.Response response) {
    return getResponse(response);
  });
}


void printWrapped(String text) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future callPostMethodWith(String url, Map<String, dynamic> params) async {

  Map<String, String> commonHeadersToken = {
    'Content-Type': 'application/json',
    'accept': '*/*',
  };

  printWrapped("params--" + jsonEncode(params));
  printWrapped("baseUrl--" + url);
  printWrapped("commonHeadersWithToken--" + jsonEncode(commonHeadersToken));
  return await http
      .post(Uri.parse(url),
          body: utf8.encode(json.encode(params)), headers: commonHeadersToken)
      .then((http.Response response) {
    return getResponse(response);
  });
}

Future callPostMethodWithAuth(String url, Map<String, dynamic> params, {String? accept}) async {

  Map<String, String> commonHeadersToken = {
    'Content-Type': 'application/json',
    'accept': accept ?? '*/*',
    'Authorization' : 'Bearer ${PreferenceHelper.getString(PreferenceHelper.AUTH_TOKEN)}' ?? ''
  };

  printWrapped("params--" + jsonEncode(params));
  printWrapped("baseUrl--" + url);
  printWrapped("commonHeadersWithToken--" + jsonEncode(commonHeadersToken));
  return await http
      .post(Uri.parse(url),
      body: utf8.encode(json.encode(params)), headers: commonHeadersToken)
      .then((http.Response response) {
    return getResponse(response);
  });
}


Future getResponse(Response response) async {
  final int statusCode = response.statusCode;
  printWrapped("response--statusCode--" + response.statusCode.toString());
  printWrapped("response--" + response.body);
  if (statusCode == 500 || statusCode == 502) {
    return "{\"status\":\"false\",\"message\":\"Internal server issue\"}";
  } else if (statusCode == 401) {
    // MyAppState.navKey.currentContext;
    final parsedJson = jsonDecode(response.body.toString());
    final message = parsedJson['message'].toString();
    //AppUtils.errorMessage='Unauthorised user';
    return "{\"status\":\"false\",\"message\":\"${message}\"}";
  } else if (statusCode == 403) {
    //  Unauthorised streams = Unauthorised.fromJson(json.decode(response.body));
    // return "{\"status\":\"0\",\"message\":\"${streams.message}\"}";
    return "{\"status\":\"false\",\"message\":\"Internal server issue\"}";
  } else if (statusCode == 405) {
    String error = "This Method not allowed.";
    printWrapped("response--" + error);
    return "{\"status\":\"0\",\"message\":\"${error}\"}";
  } else if (statusCode == 400) {
    // Unauthorised streams = Unauthorised.fromJson(json.decode(response.body));
    // return "{\"status\":\"0\",\"message\":\"${streams.message}\"}";
    return "{\"status\":\"0\",\"message\":\"Bad Request response\"}";
  } else if (statusCode == 422) {
    String error = response.body;
    // Map<String, dynamic> data = jsonDecode(response.body);
    final parsedJson = jsonDecode(response.body.toString());
    final message = parsedJson['message'].toString();
    print('==============344 $message');
    printWrapped("---sa-Add" + message.replaceAll(new RegExp(r'[^\w\s]+'), ''));
    printWrapped("---sa-Add" + message.replaceAll(new RegExp(r'[^\w\s]+'), ''));
    String error1=message.replaceAll(new RegExp(r'[^\w\s]+'), '');
    return "{\"status\":\"false\",\"message\":\"$error1\"}";
  } else if (statusCode < 200 || statusCode > 404 || json == null) {
    String error = response.headers['message'].toString();
    printWrapped("response--" + error);
    return "{\"status\":\"0\",\"message\":\"${error}\"}";
  }
  return response.body;
}
