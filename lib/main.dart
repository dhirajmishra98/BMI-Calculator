import 'package:calculate_bmi/utils/utils.dart';
import 'package:in_app_update/in_app_update.dart';

import 'screens/home_screen.dart';
import 'utils/global_variables.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //using in_app_update package
  @override
  void initState() {
    super.initState();
    callInit();
  }

  Future<void> callInit() async {
    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              showSnackbar(
                  message: "App updated successfully!",
                  context: context,
                  isValidation: false);
            }
          });
        }
      }
    }).catchError((e) {
      showSnackbar(
          message: "App update failed!", context: context, isValidation: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          actionsIconTheme: IconThemeData(color: Colors.white),
          backgroundColor: blueColor,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
