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
              const Image(
                image: AssetImage('assets/images/logo.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.account_balance_sharp,
                      color: CustomColors.buttonBackgroundColor),
                  Text('All_ To-dos')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.category,
                      color: CustomColors.buttonBackgroundColor),
                  Text('Categories')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.ac_unit,
                      color: CustomColors.buttonBackgroundColor),
                  Text('Bookings')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.settings,
                      color: CustomColors.buttonBackgroundColor),
                  Text('Settings')
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12),
                child: Divider(
                  thickness: 2,
                ),
              ),
              const Text(
                'RATE ON PLAY STORE',
              ),
              const Text('SEND US FEEDBACK'),
              const Text('SHARE THIS APP'),
              const Text('PRIVACY POLICY'),
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
