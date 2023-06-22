import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_planner/main.dart';
import 'package:wedding_planner/modelClasses/employee_info.dart';
import 'package:wedding_planner/modelClasses/model_personal_login_info.dart';
import 'package:wedding_planner/modelClasses/model_tasks_handler.dart';
import 'package:wedding_planner/repository/utils/model_location.dart';

Widget get mayaRingProviders{
  return MultiProvider(providers: [
    ChangeNotifierProvider<LocationPicker>(
      create: (context) => LocationPicker(),
    ),
    ChangeNotifierProvider<ModelPersonalLoginInfo>(
      create: (context) => ModelPersonalLoginInfo(),
    ),
    ChangeNotifierProvider<ModelEmployeeInfo>(
      create: (context) => ModelEmployeeInfo(),
    ),
    ChangeNotifierProvider<ModelTasksHandler>(
      create: (context) => ModelTasksHandler(),
    ),
  ],child:  MyApp(),);
}