import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofatesh/cubit/ratings_cubit/cubit.dart';
import 'package:mofatesh/layout/home_layout.dart';
import 'package:mofatesh/network/local/cache_helper.dart';
import 'package:mofatesh/network/remote/dio_helper.dart';
import 'package:mofatesh/shared/constants.dart';
import 'package:mofatesh/shared/themes.dart';

import 'cubit/bloc_observer.dart';
import 'modules/login_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token') ?? '';
  BlocOverrides.runZoned(
    () {
      runApp(
        MyApp(token: token,),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  final String token;

  const MyApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RatingsCubit()..getRatingsData()..getUnits()..getCompaniesData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: token.isEmpty ? LoginScreen() : HomeLayOut(),
      ),
    );
  }
}
