import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'package:health_studio_user/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Duration timeout = Duration(seconds: 30);

Future<Map<String, dynamic>> postRequest(url, body) async {
  log(baseURL + url);
  log(body.toString());
  log("HEADERSS");
  log((await getHeaders()).toString());
  FormData formData = FormData.fromMap(body);
  final Response response = await Dio()
      .post(
    baseURL + url,
    data: formData,
    options: Options(
      headers: await getHeaders(),
    ),
  )
      .timeout(timeout, onTimeout: () {
    return Future.value(Response(
        requestOptions: RequestOptions(path: url),
        data: timeoutResponse(),
        statusCode: 400));
  }).catchError((error) {
    return getErrorMessage(error);
  });
  log("BODY == ${response.data}");
  log("STATUS CODE ${response.statusCode}");
  Map<String, dynamic> responseBody = response.data;
  return responseBody;
}

Future<Map<String, dynamic>> putRequest(url, body) async {
  log(baseURL + url);
  log(body.toString());
  FormData formData = FormData.fromMap(body);

  final Response response = await Dio()
      .put(baseURL + url,
          data: formData,
          options: Options(
            headers: await getHeaders(),
          ))
      .timeout(timeout, onTimeout: () {
    return Future.value(Response(
        requestOptions: RequestOptions(path: url),
        data: timeoutResponse(),
        statusCode: 400));
  }).catchError((error) {
    return getErrorMessage(error);
  });
  log("BODY ${response.data}");
  log("STATUS CODE ${response.statusCode}");
  Map<String, dynamic> responseBody = response.data;

  if (responseBody['status'].toString().toLowerCase() == 'success' ||
      responseBody['status'] == 'error') {
    responseBody.putIfAbsent("success", () => true);
  }
  return responseBody;
}

Future<Map<String, dynamic>> getRequest(url) async {
  log("HEADERSS");
  log((await getHeaders()).toString());
  log(baseURL + url);
  final Response response = await Dio()
      .get(baseURL + url,
          options: Options(
            headers: await getHeaders(),
          ))
      .timeout(timeout, onTimeout: () {
    return Future.value(
      Response(
        requestOptions: RequestOptions(path: url),
        data: timeoutResponse(),
        statusCode: 400,
      ),
    );
  }).catchError((error) {
    return getErrorMessage(error);
  });
  log("BODY ${response.data}");
  log("STATUS CODE ${response.statusCode}");
  Map<String, dynamic> responseBody = response.data;
  return responseBody;
}

Future<Map<String, dynamic>> deleteRequest(url) async {
  log("HEADERS");
  log((await getHeaders()).toString());
  log(baseURL + url);
  final Response response = await Dio()
      .delete(baseURL + url,
          options: Options(
            headers: await getHeaders(),
          ))
      .timeout(timeout, onTimeout: () {
    return Future.value(
      Response(
        requestOptions: RequestOptions(path: url),
        data: timeoutResponse(),
        statusCode: 400,
      ),
    );
  }).catchError((error) {
    return getErrorMessage(error);
  });
  log("BODY ${response.data}");
  log("STATUS CODE ${response.statusCode}");
  Map<String, dynamic> responseBody = response.data;
  return responseBody;
}

Map<String, dynamic> timeoutResponse() {
  return {
    "success": false,
    "message": "Please check your network connection and try again.",
    "error": 1,
  };
}

Map<String, dynamic> errorResponse() {
  return {
    "success": false,
    "message": "Something went wrong, please try again.",
    "error": 1
  };
}

Future<Map<String, String>> getHeaders() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('auth_key') == null) {
    return {
      'Content-Type': 'application/x-www-form-urlencoded',
      HttpHeaders.authorizationHeader: "d271386f894ff9aa6febbc0121b860bb"
    };
  } else {
    return {
      'Content-Type': 'application/x-www-form-urlencoded',
      'UserAuth': "${prefs.getString("auth_key")}",
      HttpHeaders.authorizationHeader: "d271386f894ff9aa6febbc0121b860bb"
    };
  }
}

getErrorMessage(error) {
  if (error.toString().contains("SocketException:")) {
    return Future.value(
      Response(
        requestOptions: RequestOptions(path: ""),
        data: timeoutResponse(),
        statusCode: 400,
      ),
    );
  } else {
    return Future.value(
      Response(
        requestOptions: RequestOptions(path: ""),
        data: timeoutResponse(),
        statusCode: 400,
      ),
    );
  }
}
