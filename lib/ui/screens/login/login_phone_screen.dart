import 'package:flutter/material.dart';
import 'package:sys_mobile/ui/utils/app_images.dart';
import 'package:sys_mobile/ui/utils/theme.dart';
import 'package:sys_mobile/ui/utils/widgets.dart';

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SysAppTheme().backgroundColor,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello there...',
                  style: SysAppTheme().textStyle(
                    fontSize: SysAppTheme().fontSizeBannerHeading,
                    fontWeight: SysAppTheme().fontWeightBannerHeading,
                    color: SysAppTheme().textColor,
                  ),
                ),
                const SizedBox(height: 10,),
                TextFieldBox(
                  padding: const EdgeInsets.only(left: 0, right: 25),
                  hintText: 'Enter phone',
                  leadingIcon: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AppImages.indianFlagCircular(),
                        radius: 14,
                      ),
                      const SizedBox(width: 10,),
                      Text(
                        '+91',
                        style: SysAppTheme().textStyle(
                          fontSize: SysAppTheme().fontSizeDefaultHeading,
                          fontWeight: SysAppTheme().fontWeightDefaultHeading,
                          color: SysAppTheme().textColor,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        height: 24,
                        width: 1,
                        color: SysAppTheme().borderGrey,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Button(
              // text: 'Login',
              icon: Icon(
                Icons.chevron_right,
                color: SysAppTheme().buttonTextColor,
              )
            ),
          ],
        ),
      ),
    );
  }
}
