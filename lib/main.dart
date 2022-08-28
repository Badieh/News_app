import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/modules/splash_screen.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';
import 'package:news_app/shared/cubit/app_states.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';
import 'package:news_app/shared/network/remote/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  // In case of installing for the first time
  // Islight would bes stored null , then initialise it
  if (CacheHelper.getData(key: 'isLight') == null) {
    CacheHelper.putData(key: 'isLight', value: true);
  }
  bool? isLight = CacheHelper.getData(key: 'isLight');

  runApp(MyApp(isLight!));
}

class MyApp extends StatelessWidget {
  bool isLight = true;
  MyApp(this.isLight);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //NewsCubit
        BlocProvider(
          create: (context) => NewsCubit()..getBusiness(),
        ),
        // AppCubit
        BlocProvider(
          create: (context) => AppCubit()..changeTheme(fromShared: isLight),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, states) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            themeMode: AppCubit().get(context).isLight
                ? ThemeMode.light
                : ThemeMode.dark,
            theme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    )),
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.black),
                  centerTitle: true,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  actionsIconTheme: IconThemeData(color: Colors.black)),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black)),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.shifting,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
              ),
            ),
            darkTheme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    )),
              ),
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white),
                  centerTitle: true,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black12,
                    statusBarBrightness: Brightness.light,
                  ),
                  backgroundColor: Colors.black12,
                  elevation: 0,
                  actionsIconTheme: IconThemeData(color: Colors.white)),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white)),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.black12,
                type: BottomNavigationBarType.shifting,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
              ),
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
