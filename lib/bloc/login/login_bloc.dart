import 'package:dio/dio.dart';
import 'package:sys_mobile/bloc/login/login_event.dart';
import 'package:sys_mobile/bloc/login/login_state.dart';
import 'package:sys_mobile/common/base_bloc.dart';
import 'package:sys_mobile/models/login/verify_otp_model.dart';
import 'package:sys_mobile/repository/login_repository.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  LoginState getErrorState() => LoginFailedState();

  @override
  Stream<LoginState> handleEvents(LoginEvent event) async* {
    if (event is MobileNumberExistEvent) {
      yield* _handleMobileNumberExistEvent(event);
    }
    if (event is UserLoginEvent) {
      yield* _handleUserLoginEvent(event);
    }
    if (event is VerifyOTPEvent) {
      yield* _handleVerifyOTPEvent(event);
    }
    if (event is SendOTPEvent) {
      yield* _handleSendOTPEvent(event);
    }
  }

  Stream<LoginState> _handleMobileNumberExistEvent(
      MobileNumberExistEvent event) async* {
    yield MobileNumberExistProgressState();
    try {
      Map<String, dynamic> body = {
        'mobileNumber': event.mobileNumber,
      };
      final Response response = await LoginRepository().isExistingUser(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        bool isExistingUser = (response.data['message']);
        yield MobileNumberExistSuccessState(isExistingUser);
      }
    } on Exception catch (ex) {
      yield MobileNumberExistFailedState(ex.toString());
    }
  }

  Stream<LoginState> _handleUserLoginEvent(UserLoginEvent event) async* {
    yield UserLoginProgressState();
    try {
      Map<String, dynamic> body = {
        'mobileNumber': event.mobileNumber,
      };
      final Response response = await LoginRepository().userLogin(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = (response.data['message']);
        yield UserLoginSuccessState(message);
      }
    } on Exception catch (ex) {
      yield UserLoginFailedState(ex.toString());
    }
  }

  Stream<LoginState> _handleVerifyOTPEvent(VerifyOTPEvent event) async* {
    yield VerifyOTPProgressState();
    try {
      Map<String, dynamic> body = {
        'mobileNumber': event.mobileNumber,
        'otp': event.otp,
      };
      final Response response = await LoginRepository().verifyOTP(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final verifyOTPModel = VerifyOTPModel.fromJson(response.data);
        yield VerifyOTPSuccessState(verifyOTPModel);
      }
    } on Exception catch (ex) {
      yield VerifyOTPFailedState(ex.toString());
    }
  }

  Stream<LoginState> _handleSendOTPEvent(SendOTPEvent event) async* {
    yield SendOTPProgressState();
    try {
      Map<String, dynamic> body = {
        'mobileNumber': event.mobileNumber,
      };
      final Response response = await LoginRepository().sendOTP(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = response.data['message'];
        yield SendOTPSuccessState(message);
      }
    } on Exception catch (ex) {
      yield SendOTPFailedState(ex.toString());
    }
  }
}
