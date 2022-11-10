import 'package:flutter/material.dart';
import 'package:wedding_planner/common_screens/chat_page.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
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
                      'Appointments',
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
                        subtitle: Text('location'),
                        trailing: Text('Time'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatPage(),
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
