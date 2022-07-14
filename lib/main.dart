import 'package:dog_walker/constants.dart';
import 'package:dog_walker/providers/location_provider.dart';
import 'package:dog_walker/screens/auth/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: GetMaterialApp(
        title: 'Dog Walker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: kSecondaryColor,
            primaryColor: kPrimaryColor,
            appBarTheme: AppBarTheme(
              backgroundColor: kSecondaryColor,
              elevation: 0,
            )),
        home: const SplashScreen(),
      ),
    );
  }
}
