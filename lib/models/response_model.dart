import 'package:ngdemo13_home/models/employee_model.dart';

class ResponseModel {
  String? status;
  Employee? employee;
  String? message;

  ResponseModel({this.status, this.employee, this.message});

  ResponseModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        employee = json['employee'],
        message = json['message'];

  Map<String, dynamic> toJson() =>
      {'status': status, 'employee': employee, 'message': message};
}
