import 'package:dog_walker/constants.dart';
import 'package:dog_walker/firebase_options.dart';
import 'package:dog_walker/providers/admin_provider.dart';
import 'package:dog_walker/providers/auth_provider.dart';
import 'package:dog_walker/providers/location_provider.dart';
import 'package:dog_walker/providers/owner_provider.dart';
import 'package:dog_walker/providers/walker_provider.dart';
import 'package:dog_walker/screens/auth/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load();
  Stripe.publishableKey = dotenv.env['PUBLISHABLE_KEY']!;
  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  // Stripe.urlScheme = 'flutterstripe';
  // await Stripe.instance.applySettings();
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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WalkerProvider()),
        ChangeNotifierProvider(create: (_) => OwnerProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
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
