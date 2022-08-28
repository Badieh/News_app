import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';

import '../modules/search_screen.dart';
import '../shared/cubit/news_cubit.dart';
import '../shared/cubit/news_states.dart';
import '../shared/network/remote/cache_helper.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        bool? isLight = CacheHelper.getData(key: 'isLight');
        List<BottomNavigationBarItem> BottomItems = [
          BottomNavigationBarItem(
              icon: Icon(Icons.business_center),
              label: 'Business',
              backgroundColor: isLight! ? Colors.deepOrange : Colors.black ),
          BottomNavigationBarItem(
              icon: Icon(Icons.science_outlined),
              label: 'Science',
              backgroundColor: isLight ? Colors.blueAccent : Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports),
              label: 'Sports',
              backgroundColor: isLight ? Colors.green : Colors.black),
        ];
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(),
                        ));
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    // change theme in AppCubit
                    AppCubit().get(context).changeTheme();
                    // Make News cubit rebuild the state for the new them
                    cubit.themeChanged();
                  },
                  icon: AppCubit().get(context).isLight
                      ? Icon(Icons.dark_mode_outlined)
                      : Icon(Icons.light_mode_outlined)),
            ],
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: getColor(
                current_index: cubit.currentIndex,
                isLight: isLight,
              ),
              statusBarBrightness: Brightness.dark,
            ),
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: BottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );
  }
}
