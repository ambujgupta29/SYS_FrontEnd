import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sys_mobile/ui/utils/store/app_storage.dart';
import 'package:sys_mobile/ui/utils/store/storage_constants.dart';
import 'package:sys_mobile/ui/utils/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SysAppTheme().setTheme(SysAppThemes.light);
    final isloggedin = AppStorage().getBool(IS_LOGGED_IN) ?? false;
    Future.delayed(
        const Duration(milliseconds: 3000),
        () => (!isloggedin)
            ? Navigator.of(context).pushNamed('/login-phone')
            : Navigator.of(context).pushNamedAndRemoveUntil(
                '/bottom-nav', ModalRoute.withName('')));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SysAppTheme().black,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  SysAppTheme().setTheme(SysAppThemes.light);
                });
                // Navigator.of(context).pushNamed('/login-phone');
              },
              child: Text(
                'Hi',
                style: SysAppTheme().textStyle(
                  color: SysAppTheme().white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
