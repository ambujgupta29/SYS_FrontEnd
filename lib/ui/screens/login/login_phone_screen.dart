import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sys_mobile/bloc/login/login_bloc.dart';
import 'package:sys_mobile/bloc/login/login_event.dart';
import 'package:sys_mobile/bloc/login/login_state.dart';
import 'package:sys_mobile/common/loader_control.dart';
import 'package:sys_mobile/ui/utils/app_images.dart';
import 'package:sys_mobile/ui/utils/store/app_storage.dart';
import 'package:sys_mobile/ui/utils/store/storage_constants.dart';
import 'package:sys_mobile/ui/utils/theme.dart';
import 'package:sys_mobile/ui/utils/widgets.dart';

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  LoginBloc? _loginBloc;

  TextEditingController mobileNumberController = TextEditingController();

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _loginBloc?.stream.listen(isExistingUserListener);
    super.initState();
  }

  Future<void> isExistingUserListener(state) async {
    if (state is MobileNumberExistSuccessState) {
      stopLoader(context);
      if (state.message == true) {
        _loginBloc
            ?.add(UserLoginEvent(mobileNumber: mobileNumberController.text));
        Navigator.of(context).pushNamed('/login-otp',
            arguments: {'mobileNumber': mobileNumberController.text});
      } else {
        Navigator.of(context).pushNamed('/login-signup',
            arguments: {'mobileNumber': mobileNumberController.text});
      }
    } else if (state is MobileNumberExistFailedState) {
      print(state.message);
      stopLoader(context);
    } else if (state is MobileNumberExistProgressState) {
      startLoader(context);
    } else if (state is UserLoginSuccessState) {
      print(state.message);
    } else if (state is UserLoginFailedState) {
      print(state.message);
    } else if (state is UserLoginProgressState) {}
  }

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
                  'Hello there!',
                  style: SysAppTheme().textStyle(
                    fontSize: SysAppTheme().fontSizeBannerHeading,
                    fontWeight: SysAppTheme().fontWeightBannerHeading,
                    color: SysAppTheme().textColor,
                  ),
                ),
                // const SizedBox(height: 10,),
                Text(
                  'We need your phone number to proceed. This number will be used for accessing your account in the future.',
                  style: SysAppTheme().textStyle(
                    fontSize: SysAppTheme().fontSizeBannerBody,
                    fontWeight: SysAppTheme().fontWeightDefaultBody,
                    color: SysAppTheme().textColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldBox(
                  controller: mobileNumberController,
                  padding: const EdgeInsets.only(left: 0, right: 25),
                  hintText: 'Enter number',
                  maxLength: 10,
                  leadingIcon: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AppImages.indianFlagCircular(),
                        radius: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '+91',
                        style: SysAppTheme().textStyle(
                          fontSize: SysAppTheme().fontSizeDefaultHeading,
                          fontWeight: SysAppTheme().fontWeightDefaultHeading,
                          color: SysAppTheme().textColor,
                        ),
                      ),
                    ],
                  ),
                  leadingDivider: true,
                ),
              ],
            ),
            Button(
              onTap: () {
                if (mobileNumberController.text.length == 10) {
                  _loginBloc?.add(MobileNumberExistEvent(
                      mobileNumber: mobileNumberController.text));
                  // Navigator.of(context).pushNamed('/login-otp');
                } else {
                  print('Invalid Mobile Number');
                }
              },
              text: 'Continue',
              // icon: Icon(
              //   Icons.chevron_right,
              //   color: SysAppTheme().buttonTextColor,
              // ),
            ),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 80),
      //   child: FloatingActionButton(
      //     onPressed: () => Navigator.of(context).pushNamed('/login-signup'),
      //     backgroundColor: SysAppTheme().buttonColor,
      //     child: Icon(
      //       Icons.person_add_rounded,
      //       color: SysAppTheme().buttonTextColor,
      //     ),
      //   ),
      // ),
    );
  }
}
