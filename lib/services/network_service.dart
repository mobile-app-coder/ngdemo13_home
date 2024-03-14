import 'dart:convert';

import 'package:http/http.dart';
import 'package:ngdemo13_home/models/Employees.dart';
import 'package:ngdemo13_home/models/employee_model.dart';

class Network {
  static String BASES = "dummy.restapiexample.com";
  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static String API_EMPLOYE_LIST = "/api/v1/employees";
  static String API_EMPLOYE = "/api/v1/employee";
  static String API_EMPLOYE_CREATE = "/api/v1/create";
  static String API_EMPLOYE_DELETE = "/api/v1/delete/";
  static String API_EMPLOYE_UPDATE = "/api/v1/update/";

  //get data
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.http(BASES, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  //create
  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.http(BASES, api, params);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DELETE(String api, Map<String, String> params) async {
    var uri = Uri.http(BASES, api, params);
    var response = await delete(uri, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = Map();
    return params;
  }

  //params to create
  static Map<String, String> paramsToCreate(Employee employee) {
    Map<String, String> params = Map();
    params.addAll({
      'employee_name': employee.employee_name!,
      'employee_salary': employee.employee_salary!,
      'employee_age': employee.employee_age!,
    });
    return params;
  }

  //update
  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.http(BASES, api, params);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Map<String, String> paramsToUpdate(Employee employee) {
    Map<String, String> params = Map();
    params.addAll({
      'id': employee.id.toString(),
      'employee_name': employee.employee_name!,
      'employee_salary': employee.employee_salary.toString(),
      'employee_age': employee.employee_age.toString(),
    });
    return params;
  }

  static List<Datum> parseEmployees(String response) {
    dynamic json = jsonDecode(response);
    return Employees.fromJson(json).data;
  }
}
