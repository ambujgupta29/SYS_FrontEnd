import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sys_mobile/bloc/login/login_bloc.dart';
import 'package:sys_mobile/bloc/login/product/product_bloc.dart';
import 'package:sys_mobile/bloc/profile/profile_bloc.dart';
import 'package:sys_mobile/ui/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:sys_mobile/ui/screens/login/login_otp_screen.dart';
import 'package:sys_mobile/ui/screens/login/login_phone_screen.dart';
import 'package:sys_mobile/ui/screens/productDetail/product_detail_screen.dart';
import 'package:sys_mobile/ui/screens/profile/profile_screen.dart';
import 'package:sys_mobile/ui/screens/login/login_signup_screen.dart';
import 'package:sys_mobile/ui/screens/splash/splash_screen.dart';
import 'package:sys_mobile/ui/screens/user_product_list_screen.dart';
import 'package:sys_mobile/ui/utils/store/app_storage.dart';
import 'package:sys_mobile/ui/utils/store/storage_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  runApp(
    MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return CupertinoPageRoute(builder: (context) {
            return SplashScreen();
          });
        } else if (settings.name == '/login-phone') {
          return CupertinoPageRoute(builder: (context) {
            return BlocProvider(
              create: (context) => LoginBloc(),
              child: LoginPhoneScreen(),
            );
          });
        } else if (settings.name == '/login-signup') {
          return CupertinoPageRoute(builder: (context) {
            return BlocProvider(
              create: (context) => LoginBloc(),
              child: LoginSignupScreen(arguments: settings.arguments),
            );
          });
        } else if (settings.name == '/login-otp') {
          return CupertinoPageRoute(builder: (context) {
            return BlocProvider(
              create: (context) => LoginBloc(),
              child: LoginOtpScreen(arguments: settings.arguments),
            );
          });
        } else if (settings.name == '/profile') {
          return CupertinoPageRoute(builder: (context) {
            return BlocProvider(
              create: (context) => ProfileBloc(),
              child: ProfileScreen(arguments: settings.arguments),
            );
          });
        } else if (settings.name == '/bottom-nav') {
          return CupertinoPageRoute(builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<ProductsBloc>(
                  create: (BuildContext context) => ProductsBloc(),
                ),
                BlocProvider<ProfileBloc>(
                  create: (BuildContext context) => ProfileBloc(),
                ),
              ],
              child: BottomNavBarScreen(arguments: settings.arguments),
            );
          });
        } else if (settings.name == '/product-detail') {
          return CupertinoPageRoute(builder: (context) {
            return BlocProvider(
              create: (context) => ProductsBloc(),
              child: ProductDetailScreen(arguments: settings.arguments),
            );
          });
        } else if (settings.name == '/UserproductListing') {
          return CupertinoPageRoute(builder: (context) {
            return BlocProvider(
              create: (context) => ProductsBloc(),
              child: UserProductListScreen(arguments: settings.arguments),
            );
          });
        }
      },
      // initialRoute: '/login',
      // routes: {
      //   '/': (context) => const SplashScreen(),
      //   '/login-phone': (context) => BlocProvider(
      //         create: (context) => LoginBloc(),
      //         child: const LoginPhoneScreen(),
      //       ),
      //   '/login-signup': (context) => BlocProvider(
      //         create: (context) => LoginBloc(),
      //         child: const LoginSignupScreen(),
      //       ),
      //   '/login-otp': (context) => BlocProvider(
      //         create: (context) => LoginBloc(),
      //         child: const LoginOtpScreen(),
      //       ),
      //   // '/dashboard': (context) => ,
      //   '/profile': (context) => const ProfileScreen(),
      //   '/bottom-nav': (context) => const BottomNavBarScreen(),
      // },
    ),
  );
}

Future<void> init() async {
  await AppStorage().getStorage();
}
