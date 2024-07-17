import 'package:bloc/bloc.dart';

import '../../utils/cache/cache.dart';

enum ThemeState { red, green }

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(CacheData.get(key: 'isRedMode') ?? false
            ? ThemeState.green
            : ThemeState.red);
  Future<void> toggleTheme() async {
    final newTheme =
        state == ThemeState.red ? ThemeState.green : ThemeState.red;
    await CacheData.set(key: 'isRedMode', value: newTheme == ThemeState.green);
    emit(newTheme);
  }

  String themeTitle() {
    return state == ThemeState.red ? "RED" : "GREEN";
  }
}
