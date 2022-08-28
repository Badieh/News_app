import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/app_states.dart';
import 'package:news_app/shared/network/remote/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  AppCubit get(context) => BlocProvider.of(context);

  bool isLight = true;

  changeTheme({bool? fromShared}) {
    // fromShared is provided only when in main (re run app)

    if (fromShared != null) {
      isLight = fromShared;
      emit(AppChangeThemeState());
    } else {
      isLight = !isLight;
      CacheHelper.putData(key: 'isLight', value: isLight).then((value) {
        emit(AppChangeThemeState());
      });
    }
  }
}
