import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sys_mobile/bloc/login/login_bloc.dart';
import 'package:sys_mobile/bloc/login/login_event.dart';
import 'package:sys_mobile/bloc/login/login_state.dart';
import 'package:sys_mobile/ui/utils/theme.dart';
import 'package:sys_mobile/ui/utils/widgets.dart';

class LoginOtpScreen extends StatefulWidget {
  const LoginOtpScreen({super.key});

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  LoginBloc? _loginBloc;
  int timerMin = 00;
  int timerSec = 30;

  void startTimer({int seconds = 30}) async {
    timerMin = seconds ~/ 60;
    timerSec = seconds % 60;

    while (timerMin > 0 || timerSec > 0) {
      await Future.delayed(const Duration(milliseconds: 1000));
      setState(() {
        if (timerSec > 0) {
          timerSec--;
        } else if (timerMin > 0) {
          timerMin--;
          timerSec = 59;
        } else {
          timerMin = 0;
          timerSec = 0;
        }
      });
    }
  }

  Future<void> verifyOtpListener(state) async {
    if (state is VerifyOTPSuccessState) {
      print(state.verifyOTPModel.message);
      print(state.verifyOTPModel.accessToken);
    } else if (state is VerifyOTPFailedState) {
      print(state.message);
    } else if (state is VerifyOTPProgressState) {}
    if (state is SendOTPSuccessState) {
      print(state.message);
    } else if (state is SendOTPFailedState) {
      print(state.message);
    } else if (state is SendOTPProgressState) {}
  }

  @override
  void initState() {
    startTimer();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Confirm OTP',
                  style: SysAppTheme().textStyle(
                    fontSize: SysAppTheme().fontSizeBannerHeading,
                    fontWeight: SysAppTheme().fontWeightBannerHeading,
                    color: SysAppTheme().textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'A 4-digit OTP has been sent to your number. Please confirm the OTP to validate your phone number.',
                  style: SysAppTheme().textStyle(
                    fontSize: SysAppTheme().fontSizeBannerBody,
                    fontWeight: SysAppTheme().fontWeightDefaultBody,
                    color: SysAppTheme().textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFieldBox(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      height: 60,
                      width: 60,
                      maxLength: 1,
                      textStyle: SysAppTheme().textStyle(
                        fontSize: SysAppTheme().fontSizeDefaultHeading * 1.2,
                        fontWeight: SysAppTheme().fontWeightDefaultHeading,
                        color: SysAppTheme().textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextFieldBox(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      height: 60,
                      width: 60,
                      maxLength: 1,
                      textStyle: SysAppTheme().textStyle(
                        fontSize: SysAppTheme().fontSizeDefaultHeading * 1.2,
                        fontWeight: SysAppTheme().fontWeightDefaultHeading,
                        color: SysAppTheme().textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextFieldBox(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      height: 60,
                      width: 60,
                      maxLength: 1,
                      textStyle: SysAppTheme().textStyle(
                        fontSize: SysAppTheme().fontSizeDefaultHeading * 1.2,
                        fontWeight: SysAppTheme().fontWeightDefaultHeading,
                        color: SysAppTheme().textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextFieldBox(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      height: 60,
                      width: 60,
                      maxLength: 1,
                      textStyle: SysAppTheme().textStyle(
                        fontSize: SysAppTheme().fontSizeDefaultHeading * 1.2,
                        fontWeight: SysAppTheme().fontWeightDefaultHeading,
                        color: SysAppTheme().textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                if (timerMin > 0 || timerSec > 0)
                  Text(
                    '${timerMin.toString().padLeft(2, '0')}:${timerSec.toString().padLeft(2, '0')}',
                    style: SysAppTheme().textStyle(
                      fontSize: SysAppTheme().fontSizeDefaultBody,
                      fontWeight: SysAppTheme().fontWeightDefaultBody,
                      color: SysAppTheme().textColor,
                    ),
                  )
                else
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Did not receive OTP?  ',
                          style: SysAppTheme().textStyle(
                            fontSize: SysAppTheme().fontSizeBannerBody,
                            fontWeight: SysAppTheme().fontWeightDefaultBody,
                            color: SysAppTheme().textColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Resend OTP',
                          style: SysAppTheme()
                              .textStyle(
                                fontSize: SysAppTheme().fontSizeBannerBody,
                                fontWeight:
                                    SysAppTheme().fontWeightDefaultHeading,
                                color: SysAppTheme().textColor,
                              )
                              .copyWith(
                                decoration: TextDecoration.underline,
                                // decorationThickness: 2,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              // todo add resend func here
                              _loginBloc?.add(
                                  SendOTPEvent(mobileNumber: "8957078301"));
                              startTimer();
                            },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            Button(
              onTap: () {
                _loginBloc?.add(
                    VerifyOTPEvent(mobileNumber: "8957078301", otp: "4122"));
              },
              // onTap: ()=>Navigator.of(context).pushNamed(''),
              text: 'Confirm',
              //   icon: Icon(
              //     Icons.chevron_right,
              //     color: SysAppTheme().buttonTextColor,
              //   )
            ),
          ],
        ),
      ),
    );
  }
}
