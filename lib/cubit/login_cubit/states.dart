import 'package:mofatesh/models/error_model.dart';
import 'package:mofatesh/models/login_model.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {

  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);

}

class LoginErrorState extends LoginStates {

}