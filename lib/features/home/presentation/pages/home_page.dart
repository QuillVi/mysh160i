import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mymotorcycle/core/constants/app_colors.dart';
import 'package:mymotorcycle/features/home/domain/entities/home_dashboard.dart';
import 'package:mymotorcycle/features/home/presentation/cubit/home_cubit.dart';
import 'package:mymotorcycle/features/home/presentation/cubit/home_state.dart';
import 'package:mymotorcycle/features/home/presentation/widgets/home_bottom_nav.dart';
import 'package:mymotorcycle/features/home/presentation/widgets/status_chip.dart';
import 'package:mymotorcycle/features/map/presentation/cubit/map_cubit.dart';
import 'package:mymotorcycle/features/map/presentation/pages/map_page.dart';
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
    context.read<MapCubit>().load();
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
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.neon),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            fit: StackFit.expand,
            children: [
              if (state.selectedTab == 0)
                Positioned.fill(
                  child: Image.asset(
                    'sh160i.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              SafeArea(
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 650),
                      switchInCurve: Curves.easeOutQuart,
                      switchOutCurve: Curves.easeInOutCubicEmphasized,
                      transitionBuilder: (child, animation) {
                        final slide = Tween<Offset>(
                          begin: const Offset(0.06, 0),
                          end: Offset.zero,
                        ).animate(animation);
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(position: slide, child: child),
                        );
                      },
                      layoutBuilder: (currentChild, previousChildren) {
                        return Stack(
                          children: [
                            ...previousChildren,
                            ?currentChild,
                          ],
                        );
                      },
                      child: KeyedSubtree(
                        key: ValueKey(state.selectedTab),
                        child: switch (state.selectedTab) {
                          0 => _HomeMainContent(dashboard: dashboard),
                          1 => const MyCarPage(),
                          2 => const MapPage(),
                          _ => const SettingPage(),
                        },
                      ),
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
            ],
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
              const _AnimatedProfileAvatar(),
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
              const _AnimatedSettingButton(),
              const SizedBox(width: 10),
              const _AnimatedNotifyButton(),
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
                  child: _AnimatedBatteryBadge(
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
                      const _AnimatedSunIcon(),
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

class _AnimatedNotifyButton extends StatelessWidget {
  const _AnimatedNotifyButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: AppColors.neon,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Lottie.asset(
        'assets/lottie/notification_bell.json',
        width: 32,
        height: 32,
        fit: BoxFit.contain,
        repeat: true,
      ),
    );
  }
}

class _AnimatedSettingButton extends StatelessWidget {
  const _AnimatedSettingButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Lottie.asset(
        'assets/lottie/setting.json',
        width: 32,
        height: 32,
        fit: BoxFit.contain,
        repeat: true,
      ),
    );
  }
}

class _AnimatedBatteryBadge extends StatelessWidget {
  const _AnimatedBatteryBadge({required this.percent});

  final int percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.neon,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Lottie.asset(
            'assets/lottie/electric.json',
            width: 32,
            height: 32,
            fit: BoxFit.contain,
            repeat: true,
          ),
          const SizedBox(height: 10),
          Text(
            '$percent%',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedSunIcon extends StatelessWidget {
  const _AnimatedSunIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Lottie.asset(
        'assets/lottie/looping_sun.json',
        fit: BoxFit.contain,
        repeat: true,
      ),
    );
  }
}

class _AnimatedProfileAvatar extends StatelessWidget {
  const _AnimatedProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.white,
      child: Lottie.asset(
        'assets/lottie/nav_profile.json',
        width: 30,
        height: 30,
        fit: BoxFit.contain,
        repeat: true,
      ),
    );
  }
}
