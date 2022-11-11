import 'package:flutter/material.dart';
import 'package:wedding_planner/service_provider_interface/employee_section/employee_profile_details.dart';

import '../../repository/utils/data_constants.dart';

class EmployeesList extends StatefulWidget {
  const EmployeesList({Key? key}) : super(key: key);

  @override
  State<EmployeesList> createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/front_page.png",
              alignment: Alignment.center, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.only(
                top: ScreenPading.topPading,
                left: ScreenPading.leftPading,
                right: ScreenPading.leftPading),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IconButton(
                //     padding: EdgeInsets.only(top: 8),
                //     alignment: Alignment.topLeft,
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     icon: Icon(
                //       Icons.arrow_back_ios,
                //       color: CustomColors.backGroundColor,
                //     )),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'My Employees',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.backGroundColor),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 14,
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: CustomColors.buttonBackgroundColor,
                          child: Icon(Icons.person),
                        ),
                        title: Text('Mahar Ghazanfar'),
                        subtitle: Text('Phone'),
                        //trailing: Text('Phone'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const EmployeeProfilePage(),
                              ));
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
