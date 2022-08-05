import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofatesh/cubit/login_cubit/cubit.dart';
import 'package:mofatesh/cubit/login_cubit/states.dart';
import 'package:mofatesh/layout/home_layout.dart';
import 'package:mofatesh/network/local/cache_helper.dart';
import 'package:mofatesh/shared/constants.dart';
import 'package:mofatesh/shared/methods.dart';
import 'package:mofatesh/shared/widgets/reusable_button.dart';
import 'package:mofatesh/shared/widgets/reusable_text_field.dart';
import '../shared/widgets/reusable_toast.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(
              msg: 'الرجاء ادخال بيانات صحيحة',
              toastStates: ToastStates.ERROR,
            );
          } else if (state is LoginSuccessState) {
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.accessToken)
                .then(
              (value) async {
                await CacheHelper.saveData(key: 'userId', value: state.loginModel.user!.id);
                print('user id is $userId');
                navigateToAndFinish(
                  widget: HomeLayOut(),
                  context: context,
                );
              },
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);

          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                const Image(
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                  image: AssetImage(
                    'assets/images/background.jpeg',
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Image(
                              height: 200,
                              image: AssetImage(
                                'assets/images/logo.png',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              'تسجيل الدخول',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ReusableTextField(
                            onChange: (val){},
                            controller: emailController,
                            textLabel: 'الايميل',
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'من فضلك قم بادخال الايميل.';
                              }
                            },
                            type: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ReusableTextField(
                            onChange: (val){},
                            controller: passwordController,
                            textLabel: 'كلمة المرور',
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'من فضلك قم بادخال كلمة المرور.';
                              }
                            },
                            type: TextInputType.text,
                            isPassword: true,
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          state is LoginLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : reusableButton(
                                  width: double.infinity,
                                  text: 'دخول',
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
