import 'package:flutter/material.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Appointments',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: CustomColors.appBarColor,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          // color: Colors.white70,
          child: ListView.builder(
            itemCount: 5,
            itemExtent: 70,
            itemBuilder: (context, index) => const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person),
                ),
                title: Text('Mahar Ghazanfar'),
                subtitle: Text('location'),
                trailing: Text('Time')),
          ),
        ),
      ),
    );
  }
}
