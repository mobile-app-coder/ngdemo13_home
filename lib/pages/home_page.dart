import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ngdemo13_home/models/employee_model.dart';
import 'package:ngdemo13_home/pages/employee_add_page.dart';
import 'package:ngdemo13_home/services/log_service.dart';
import 'package:ngdemo13_home/services/network_service.dart';

import '../models/Employees.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String data = "no data";
  List<Datum> employees = [];

  //load data
  loadData() async {
    var response = await Network.GET(Network.API_EMPLOYE_LIST, {});
    if (response != null) {
      setState(() {
        data = response;
        employees = Network.parseEmployees(response);
      });
    } else {
      print("no list");
    }
  }

  updateEmployee() async {
    var employee = Employee(
        employee_name: "Sardor", employee_age: "15", employee_salary: "3000");
    var response = await Network.PUT(
        Network.API_EMPLOYE_UPDATE + employee.id.toString(),
        Network.paramsToUpdate(employee));
    if (response != null) {
      setState(() {
        data = response;
        LogService.i(response);
      });
    } else {
      print("null");
    }
  }

  deleteEmployee(int id, Datum employee) async {
    var response = await Network.DELETE(
        Network.API_EMPLOYE_DELETE + id.toString(), Network.paramsEmpty());
    if(response!= null){
      employees.remove(employee);
    }
    LogService.i("$response");
  }

  @override
  void initState() {
    super.initState();
    loadData();
    //createEmployee();
    //updateEmployee();
  }

  Future openAddPage() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return EmployeeAddPage();
    }));
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openAddPage();
        },
        child: const Text("Add"),
      ),
      appBar: AppBar(
        title: const Text("Employees"),
      ),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (employee, index) {
          return employeeItem(employees[index]);
        },
      ),
    );
  }

  void doNothing(BuildContext context) {}

  Widget employeeItem(Datum employee) {
    return Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (BuildContext) {
                setState(() {

                });
                deleteEmployee(employee.id, employee);
                LogService.i(employee.id.toString());
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              flex: 1,
              onPressed: doNothing,
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name: ${employee.employeeName}",
                style: TextStyle(fontSize: 18),
              ),
              Text("age: ${employee.employeeAge}"),
              Text("salary: \$${employee.employeeSalary}"),
              Divider(
                thickness: 1,
              )
            ],
          ),
        ));
  }
}
