import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

class MyCustomDrawer extends StatefulWidget {
  const MyCustomDrawer({Key? key}) : super(key: key);

  @override
  State<MyCustomDrawer> createState() => _MyCustomDrawerState();
}

class _MyCustomDrawerState extends State<MyCustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: CustomWidget.myCustomDrawer(
          context: context,
          width: MediaQuery.of(context).size.width * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image(
                image: AssetImage('assets/images/logo.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.account_balance_sharp,
                      color: CustomColors.buttonBackgroundColor),
                  Text('All_ To-dos')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.category,
                      color: CustomColors.buttonBackgroundColor),
                  Text('Categories')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.ac_unit,
                      color: CustomColors.buttonBackgroundColor),
                  Text('Bookings')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.settings,
                      color: CustomColors.buttonBackgroundColor),
                  Text('Settings')
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Text(
                'RATE ON PLAY STORE',
              ),
              Text('SEND US FEEDBACK'),
              Text('SHARE THIS APP'),
              Text('PRIVACY POLICY'),
            ],
          )),
      body: Center(
        child: Column(
          children: const [Text('Hello World')],
        ),
      ),
    );
  }
}
