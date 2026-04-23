import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymotorcycle/core/theme/app_theme.dart';
import 'package:mymotorcycle/features/detail/data/repositories/detail_repository_impl.dart';
import 'package:mymotorcycle/features/detail/domain/usecases/get_detail_info.dart';
import 'package:mymotorcycle/features/detail/presentation/cubit/detail_cubit.dart';
import 'package:mymotorcycle/features/home/data/repositories/home_repository_impl.dart';
import 'package:mymotorcycle/features/home/domain/usecases/get_home_dashboard.dart';
import 'package:mymotorcycle/features/home/presentation/cubit/home_cubit.dart';
import 'package:mymotorcycle/features/home/presentation/pages/home_page.dart';
import 'package:mymotorcycle/features/mycar/data/repositories/my_car_repository_impl.dart';
import 'package:mymotorcycle/features/mycar/domain/usecases/get_my_car_info.dart';
import 'package:mymotorcycle/features/mycar/presentation/cubit/my_car_cubit.dart';
import 'package:mymotorcycle/features/setting/data/repositories/setting_repository_impl.dart';
import 'package:mymotorcycle/features/setting/domain/usecases/get_setting_info.dart';
import 'package:mymotorcycle/features/setting/presentation/cubit/setting_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final homeRepository = HomeRepositoryImpl();
    final detailRepository = DetailRepositoryImpl();
    final myCarRepository = MyCarRepositoryImpl();
    final settingRepository = SettingRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCubit(GetHomeDashboard(homeRepository)),
        ),
        BlocProvider(
          create: (_) => DetailCubit(GetDetailInfo(detailRepository)),
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
        home: const HomePage(),
      ),
    );
  }
}
