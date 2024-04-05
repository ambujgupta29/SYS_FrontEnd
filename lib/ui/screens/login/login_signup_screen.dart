import 'package:flutter/material.dart';
import 'package:sys_mobile/ui/utils/theme.dart';
import 'package:sys_mobile/ui/utils/widgets.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SysAppTheme().backgroundColor,
      body: Container(
        margin: const EdgeInsets.only(top: 100),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            TextFieldBox(
              margin: const EdgeInsets.only(top: 20,),
              leadingIcon: Icon(Icons.person, color: SysAppTheme().textColor,),
              leadingDivider: true,
              hintText: 'Full name',
            ),
            TextFieldBox(
              margin: const EdgeInsets.only(top: 20,),
              leadingIcon: Icon(Icons.tag_rounded, color: SysAppTheme().textColor,),
              leadingDivider: true,
              hintText: 'Username',
            ),
            TextFieldBox(
              margin: const EdgeInsets.only(top: 20,),
              leadingIcon: Icon(Icons.phone_android_rounded, color: SysAppTheme().textColor,),
              leadingDivider: true,
              hintText: 'Mobile',
            ),
            TextFieldBox(
              margin: const EdgeInsets.only(top: 20,),
              leadingIcon: Icon(Icons.alternate_email, color: SysAppTheme().textColor,),
              leadingDivider: true,
              hintText: 'E-mail',
            ),
            const Spacer(),
            Button(
              onTap: () {
              },
              // text: 'Login',
              icon: Icon(
                Icons.chevron_right,
                color: SysAppTheme().buttonTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
