import 'package:flutter/material.dart';
import 'package:sys_mobile/ui/screens/login/login_phone_screen.dart';
import 'package:sys_mobile/ui/screens/splash/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    // initialRoute: '/login',
    routes: {
      '/': (context) => const SplashScreen(),
      '/login-phone': (context) => const LoginPhoneScreen(),
      // '/login-signup': (context) => ,
      // '/login-otp': (context) => ,
      // '/dashboard': (context) => ,
    },
  ));
}