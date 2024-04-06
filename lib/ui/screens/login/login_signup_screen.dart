import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sys_mobile/bloc/login/login_bloc.dart';
import 'package:sys_mobile/bloc/login/login_event.dart';
import 'package:sys_mobile/bloc/login/login_state.dart';
import 'package:sys_mobile/common/loader_control.dart';
import 'package:sys_mobile/ui/utils/theme.dart';
import 'package:sys_mobile/ui/utils/widgets.dart';

class LoginSignupScreen extends StatefulWidget {
  final dynamic arguments;
  const LoginSignupScreen({super.key, this.arguments});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  LoginBloc? _loginBloc;
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _loginBloc?.stream.listen(userSignupListener);
    mobileNumberController.text = widget.arguments['mobileNumber'];
    super.initState();
  }

  Future<void> userSignupListener(state) async {
    if (state is UserSignupSuccessState) {
      stopLoader(context);
      print(state.message);
      Navigator.of(context).pushNamed('/login-otp',arguments: {'mobileNumber': mobileNumberController.text});
    } else if (state is UserSignupFailedState) {
      stopLoader(context);
      print(state.message);
    } else if (state is UserSignupProgressState) {
      startLoader(context);
    }
  }

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
              controller: fullNameController,
              margin: const EdgeInsets.only(
                top: 20,
              ),
              leadingIcon: Icon(
                Icons.person,
                color: SysAppTheme().textColor,
              ),
              leadingDivider: true,
              hintText: 'Full name',
            ),
            TextFieldBox(
              controller: userNameController,
              margin: const EdgeInsets.only(
                top: 20,
              ),
              leadingIcon: Icon(
                Icons.tag_rounded,
                color: SysAppTheme().textColor,
              ),
              leadingDivider: true,
              hintText: 'Username',
            ),
            TextFieldBox(
              controller: mobileNumberController,
              readOnly: true,
              margin: const EdgeInsets.only(
                top: 20,
              ),
              leadingIcon: Icon(
                Icons.phone_android_rounded,
                color: SysAppTheme().textColor,
              ),
              leadingDivider: true,
              hintText: 'Mobile',
            ),
            TextFieldBox(
              controller: emailController,
              margin: const EdgeInsets.only(
                top: 20,
              ),
              leadingIcon: Icon(
                Icons.alternate_email,
                color: SysAppTheme().textColor,
              ),
              leadingDivider: true,
              hintText: 'E-mail',
            ),
            const Spacer(),
            Button(
              onTap: () {
                _loginBloc?.add(UserSignupEvent(
                    mobileNumber: mobileNumberController.text,
                    fullName: fullNameController.text,
                    email: emailController.text,
                    username: userNameController.text));
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
