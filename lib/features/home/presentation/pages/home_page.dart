import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymotorcycle/core/constants/app_colors.dart';
import 'package:mymotorcycle/core/widgets/circle_icon_button.dart';
import 'package:mymotorcycle/features/detail/presentation/cubit/detail_cubit.dart';
import 'package:mymotorcycle/features/detail/presentation/pages/detail_page.dart';
import 'package:mymotorcycle/features/home/domain/entities/home_dashboard.dart';
import 'package:mymotorcycle/features/home/presentation/cubit/home_cubit.dart';
import 'package:mymotorcycle/features/home/presentation/cubit/home_state.dart';
import 'package:mymotorcycle/features/home/presentation/widgets/battery_badge.dart';
import 'package:mymotorcycle/features/home/presentation/widgets/home_bottom_nav.dart';
import 'package:mymotorcycle/features/home/presentation/widgets/status_chip.dart';
import 'package:mymotorcycle/features/mycar/presentation/cubit/my_car_cubit.dart';
import 'package:mymotorcycle/features/mycar/presentation/pages/my_car_page.dart';
import 'package:mymotorcycle/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:mymotorcycle/features/setting/presentation/pages/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadDashboard();
    context.read<DetailCubit>().load();
    context.read<MyCarCubit>().load();
    context.read<SettingCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final dashboard = state.dashboard;
        if (dashboard == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                if (state.selectedTab == 0)
                  Positioned.fill(
                    child: Image.asset(
                      'sh160i.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                IndexedStack(
                  index: state.selectedTab,
                  children: [
                    _HomeMainContent(dashboard: dashboard),
                    const DetailPage(),
                    const MyCarPage(),
                    const SettingPage(),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 32,
                  child: HomeBottomNav(
                    selectedIndex: state.selectedTab,
                    onTap: (index) =>
                        context.read<HomeCubit>().changeTab(index),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HomeMainContent extends StatelessWidget {
  const _HomeMainContent({required this.dashboard});

  final HomeDashboard dashboard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 88),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person_outline,
                  color: AppColors.textPrimary,
                  size: 24,
                  weight: 300,
                ),
              ),
              const SizedBox(width: 14),
              Text(
                dashboard.greeting,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              const CircleIconButton(
                icon: Icons.settings_outlined,
                size: 50,
                iconSize: 24,
                iconWeight: 300,
              ),
              const SizedBox(width: 10),
              const CircleIconButton(
                icon: Icons.notifications_outlined,
                backgroundColor: AppColors.neon,
                size: 50,
                iconSize: 24,
                iconWeight: 300,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'MY MOTORCYCLE',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 2.5,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            dashboard.modelName,
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w300,
              height: 1,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          StatusChip(text: dashboard.readyText),
          const SizedBox(height: 10),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  left: 12,
                  top: 14,
                  child: BatteryBadge(
                    percent: dashboard.batteryPercent,
                  ),
                ),
                Positioned(
                  left: 14,
                  bottom: 42,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dashboard.weather.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 11,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Icon(
                        Icons.wb_sunny_outlined,
                        size: 20,
                        color: AppColors.neon,
                        weight: 300,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${dashboard.temperature}',
                            style: const TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w300,
                              height: 0.9,
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              '°C',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
