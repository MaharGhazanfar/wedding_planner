import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/providers.dart';
import 'package:wedding_planner/routing_cofiguration/route_configuration.dart';
import 'package:wedding_planner/service_provider_interface/service_provider_dashboard.dart';
import 'package:wedding_planner/user_interface/bottom_navigationBar_screen.dart';
import 'package:wedding_planner/welcome_screens/user_selection_page.dart';
import 'firebase_options.dart';
import 'modelClasses/model_personal_login_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ModelPersonalLoginInfo.prefs = await SharedPreferences.getInstance();
  runApp(mayaRingProviders);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: MaterialApp(
        onGenerateRoute: RouteConfiguration.generateRoutes,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          iconTheme: const IconThemeData(
            color: Colors.black38,
          ),
          textTheme: (Theme.of(context).textTheme.copyWith(
              bodyMedium: TextStyle(
                  color: CustomColors.backGroundColor,
                  fontWeight: FontWeight.bold),
              bodySmall: const TextStyle(
                color: Colors.black38,
              ))),
        ),
        themeMode: ThemeMode.dark,
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Ticker((_) => {});
    _ticker.start();
  }

  @override
  void dispose() {
   
    _ticker.dispose(); //

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return SplashScreenView(
      navigateRoute: 
          ModelPersonalLoginInfo.prefs!.getString(Strings.UIDPref) == null
              ? StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (ModelPersonalLoginInfo.prefs!.getString(
                            Strings.servicePref,
                          ) ==
                          Strings.serviceProvider) {
                        return const ServiceProviderDashBoard(
                          status: Strings.serviceProvider,
                        );
                      } else {
                        return BottomNavigationBarForUser(
                            status: Strings.serviceUser);
                      }
                    } else {
                      return const UserSelectionPage();
                    }
                  },
                )
              : const ServiceProviderDashBoard(status: Strings.employee),
      backgroundColor: CustomColors.greenish,
      speed: 2,
      pageRouteTransition: PageRouteTransition.SlideTransition,
      duration: 4000,
      imageSize: 300,
      imageSrc: 'assets/images/Mayaring_splash.png',
    );
  }
}
