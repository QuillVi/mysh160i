import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymotorcycle/core/theme/app_theme.dart';
import 'package:mymotorcycle/features/home/data/repositories/home_repository_impl.dart';
import 'package:mymotorcycle/features/home/domain/usecases/get_home_dashboard.dart';
import 'package:mymotorcycle/features/home/presentation/cubit/home_cubit.dart';
import 'package:mymotorcycle/features/map/data/repositories/map_repository_impl.dart';
import 'package:mymotorcycle/features/map/domain/usecases/get_map_info.dart';
import 'package:mymotorcycle/features/map/presentation/cubit/map_cubit.dart';
import 'package:mymotorcycle/features/splash/presentation/pages/splash_page.dart';
import 'package:mymotorcycle/features/mycar/data/repositories/my_car_repository_impl.dart';
import 'package:mymotorcycle/features/mycar/domain/usecases/get_my_car_info.dart';
import 'package:mymotorcycle/features/mycar/presentation/cubit/my_car_cubit.dart';
import 'package:mymotorcycle/features/setting/data/repositories/setting_repository_impl.dart';
import 'package:mymotorcycle/features/setting/domain/usecases/get_setting_info.dart';
import 'package:mymotorcycle/features/setting/presentation/cubit/setting_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Đồng bộ icon/status & thanh điều hướng hệ thống với UI tối (Android + iOS).
  // Dùng màu đen **opaque** (không transparent): transparent + SafeArea để lộ
  // vùng Flutter không vẽ → OS/Hybrid thường hiện trắng.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF000000),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarContrastEnforced: false,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final homeRepository = HomeRepositoryImpl();
    final mapRepository = MapRepositoryImpl();
    final myCarRepository = MyCarRepositoryImpl();
    final settingRepository = SettingRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCubit(GetHomeDashboard(homeRepository)),
        ),
        BlocProvider(
          create: (_) => MapCubit(GetMapInfo(mapRepository)),
        ),
        BlocProvider(
          create: (_) => MyCarCubit(GetMyCarInfo(myCarRepository)),
        ),
        BlocProvider(
          create: (_) => SettingCubit(GetSettingInfo(settingRepository)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Motorcycle',
        theme: AppTheme.light(),
        builder: (context, child) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Color(0xFF000000),
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
              systemNavigationBarColor: Color(0xFF000000),
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarContrastEnforced: false,
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
        home: const SplashPage(),
      ),
    );
  }
}
