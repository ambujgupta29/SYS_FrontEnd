import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sys_mobile/bloc/login/login_bloc.dart';
import 'package:sys_mobile/ui/screens/login/login_otp_screen.dart';
import 'package:sys_mobile/ui/screens/login/login_phone_screen.dart';
import 'package:sys_mobile/ui/screens/login/login_signup_screen.dart';
import 'package:sys_mobile/ui/screens/splash/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    // initialRoute: '/login',
    routes: {
      '/': (context) => const SplashScreen(),
      '/login-phone': (context) => BlocProvider(
            create: (context) => LoginBloc(),
            child: const LoginPhoneScreen(),
          ),
      '/login-signup': (context) => const LoginSignupScreen(),
      '/login-otp': (context) => BlocProvider(
            create: (context) => LoginBloc(),
            child: const LoginOtpScreen(),
          ),
      // '/dashboard': (context) => ,
    },
  ));
}
