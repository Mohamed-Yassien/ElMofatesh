import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofatesh/cubit/login_cubit/states.dart';
import 'package:mofatesh/models/login_model.dart';

import '../../network/endpoints.dart';
import '../../network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: LOGIN_END_POINT,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.statusCode);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel?.user?.email);
      emit(LoginSuccessState(loginModel!));
    }).catchError(
      (error) {
        emit(
          LoginErrorState(),
        );
      },
    );
  }
}
