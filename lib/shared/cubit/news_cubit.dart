import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_sceen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/shared/cubit/news_states.dart';

import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> Screens = [BusinessScreen(), ScienceScreen(), SportsScreen()];

  void changeBottomNav(index) {
    currentIndex = index;
    if (index == 1) {
      getScience();
    } else if (index == 2) {
      getSports();
    }
    emit(NewsBottomNavState());
  }

  List Business = [];

  void getBusiness() {
    if (Business.isEmpty) {
      emit(NewsBusinessLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '97a2f0178be846b897d27b8f38d8571c',
      }).then((value) {
        Business = value.data['articles'];
        //print(Business[0]['title']);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessFailState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List Sports = [];

  void getSports() {
    if (Sports.isEmpty) {
      emit(NewsSportsLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '97a2f0178be846b897d27b8f38d8571c',
      }).then((value) {
        Sports = value.data['articles'];
        //print(Sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsFailState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List Science = [];

  void getScience() {
    if (Science.isEmpty) {
      emit(NewsScienceLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '97a2f0178be846b897d27b8f38d8571c',
      }).then((value) {
        Science = value.data['articles'];
        //print(Science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceFailState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List Search = [];

  void getSearch({required String value}) {
    Search = [];
    emit(NewsSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': "$value",
      'apiKey': '97a2f0178be846b897d27b8f38d8571c',
    }).then((value) {
      Search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchFailState(error.toString()));
    });

  }

  themeChanged() {
    emit(NewsThemeChanged());
  }
}