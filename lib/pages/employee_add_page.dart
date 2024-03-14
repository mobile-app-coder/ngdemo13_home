import 'package:flutter/material.dart';
import 'package:ngdemo13_home/models/employee_model.dart';
import 'package:ngdemo13_home/services/log_service.dart';

import '../services/network_service.dart';

class EmployeeAddPage extends StatefulWidget {
  const EmployeeAddPage({super.key});

  @override
  State<EmployeeAddPage> createState() => _EmployeeAddPageState();
}

class _EmployeeAddPageState extends State<EmployeeAddPage> {
  String name = '';
  String salary = '0';
  String age = '0';
  String result = "";

  createEmployee() async {
    var employee = Employee.post(name, age, salary);
    var response = await Network.POST(
        Network.API_EMPLOYE_CREATE, Network.paramsToCreate(employee));
    if (response != null) {
      setState(() {
        result = response;
        LogService.i(response);
        backToHome();
      });
    } else {
      LogService.i("not created");
    }
  }

  backToHome()  {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new employee"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
              child: TextField(
                decoration: InputDecoration(hintText: "Name"),
                onChanged: (text) {
                  setState(() {
                    name = text;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
              child: TextField(
                decoration: InputDecoration(hintText: "age"),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  setState(() {
                    age = text;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
              child: TextField(
                decoration: InputDecoration(hintText: "salary"),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  setState(() {
                    salary = text;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  createEmployee();
                },
                shape: RoundedRectangleBorder(),
                child: Text("Add"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(result)
          ],
        ),
      ),
    );
  }
}
