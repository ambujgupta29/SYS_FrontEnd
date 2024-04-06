import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sys_mobile/bloc/login/login_bloc.dart';
import 'package:sys_mobile/bloc/login/login_event.dart';
import 'package:sys_mobile/bloc/login/login_state.dart';
import 'package:sys_mobile/common/loader_control.dart';
import 'package:sys_mobile/ui/utils/store/app_storage.dart';
import 'package:sys_mobile/ui/utils/store/storage_constants.dart';
import 'package:sys_mobile/ui/utils/theme.dart';
import 'package:sys_mobile/ui/utils/widgets.dart';

class LoginOtpScreen extends StatefulWidget {
  final dynamic arguments;
  const LoginOtpScreen({super.key, this.arguments});

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  TextEditingController? otpController = TextEditingController();
  LoginBloc? _loginBloc;
  int _secondsLeft = 30;
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer({int seconds = 30}) {
    _secondsLeft = seconds;
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_secondsLeft == 0) {
          timer.cancel();
        } else {
          _secondsLeft--;
        }
      });
    });
  }

  Future<void> verifyOtpListener(state) async {
    if (state is VerifyOTPSuccessState) {
      stopLoader(context);
      print(state.verifyOTPModel.message);
      print(state.verifyOTPModel.accessToken);
      await AppStorage()
          .putString(USER_TOKEN, state.verifyOTPModel.accessToken ?? '');
      AppStorage().putBool(IS_LOGGED_IN, true);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/bottom-nav', ModalRoute.withName(''));
    } else if (state is VerifyOTPFailedState) {
      stopLoader(context);
      print(state.message);
    } else if (state is VerifyOTPProgressState) {
      startLoader(context);
    }
    if (state is SendOTPSuccessState) {
      stopLoader(context);
      print(state.message);
      startTimer();
    } else if (state is SendOTPFailedState) {
      stopLoader(context);
      print(state.message);
    } else if (state is SendOTPProgressState) {
      startLoader(context);
    }
  }

  @override
  void initState() {
    startTimer();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _loginBloc?.stream.listen(verifyOtpListener);
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
                  height: 20,
                ),
                TextFieldBox(
                  controller: otpController,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  leadingIcon: Icon(
                    Icons.password_rounded,
                    color: SysAppTheme().textColor,
                  ),
                  leadingDivider: true,
                  hintText: 'OTP',
                  maxLength: 4,
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  height: 30,
                  alignment: Alignment.center,
                  child: _secondsLeft > 0
                      ? Text(
                          '${00.toString().padLeft(2, '0')}:${_secondsLeft.toString().padLeft(2, '0')}',
                          style: SysAppTheme().textStyle(
                            fontSize: SysAppTheme().fontSizeDefaultBody,
                            fontWeight: SysAppTheme().fontWeightDefaultBody,
                            color: SysAppTheme().textColor,
                          ),
                        )
                      : RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Did not receive OTP?   ',
                                style: SysAppTheme().textStyle(
                                  fontSize: SysAppTheme().fontSizeBannerBody,
                                  fontWeight:
                                      SysAppTheme().fontWeightDefaultBody,
                                  color: SysAppTheme().textColor,
                                ),
                              ),
                              TextSpan(
                                text: 'Resend OTP',
                                style: SysAppTheme()
                                    .textStyle(
                                      fontSize:
                                          SysAppTheme().fontSizeBannerBody,
                                      fontWeight: SysAppTheme()
                                          .fontWeightDefaultHeading,
                                      color: SysAppTheme().textColor,
                                    )
                                    .copyWith(
                                      decoration: TextDecoration.underline,
                                      // decorationThickness: 2,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    // todo add resend func here
                                    _loginBloc?.add(SendOTPEvent(
                                        mobileNumber:
                                            widget.arguments['mobileNumber']));
                                  },
                              ),
                            ],
                          ),
                        ),
                ),
                // if (timerMin > 0 || timerSec > 0)
                //   Text(
                //     '${timerMin.toString().padLeft(2,'0')}:${timerSec.toString().padLeft(2,'0')}',
                //     style: SysAppTheme().textStyle(
                //       fontSize: SysAppTheme().fontSizeDefaultBody,
                //       fontWeight: SysAppTheme().fontWeightDefaultBody,
                //       color: SysAppTheme().textColor,
                //     ),
                //   )
                // else
                //   RichText(
                //     text: TextSpan(
                //       children: [
                //         TextSpan(
                //           text: 'Did not receive OTP?  ',
                //           style: SysAppTheme().textStyle(
                //             fontSize: SysAppTheme().fontSizeBannerBody,
                //             fontWeight: SysAppTheme().fontWeightDefaultBody,
                //             color: SysAppTheme().textColor,
                //           ),
                //         ),
                //         TextSpan(
                //           text: 'Resend OTP',
                //           style: SysAppTheme().textStyle(
                //             fontSize: SysAppTheme().fontSizeBannerBody,
                //             fontWeight: SysAppTheme().fontWeightDefaultHeading,
                //             color: SysAppTheme().textColor,
                //           ).copyWith(
                //             decoration: TextDecoration.underline,
                //             // decorationThickness: 2,
                //           ),
                //           recognizer: TapGestureRecognizer()
                //             ..onTap = () async {
                //               // todo add resend func here
                //               startTimer();
                //             },
                //         ),
                //       ],
                //     ),
                //   )
              ],
            ),
            Button(
              onTap: () {
                _loginBloc?.add(VerifyOTPEvent(
                    mobileNumber: widget.arguments['mobileNumber'],
                    otp: otpController?.text ?? ''));
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
