import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mymotorcycle/core/constants/app_colors.dart';
import 'package:mymotorcycle/features/home/presentation/widgets/status_chip.dart';
import 'package:mymotorcycle/features/mycar/domain/entities/my_car_info.dart';
import 'package:mymotorcycle/features/mycar/presentation/cubit/my_car_cubit.dart';
import 'package:mymotorcycle/features/mycar/presentation/widgets/my_car_stat_row.dart';

class MyCarPage extends StatelessWidget {
  const MyCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCarCubit, MyCarState>(
      builder: (context, state) {
        final info = state.info;
        if (info == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.asset(
                'sh160i.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.35),
                      Colors.black.withValues(alpha: 0.55),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 88),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const _AnimatedProfileAvatar(),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          info.greeting,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const _AnimatedSettingButton(),
                      const SizedBox(width: 10),
                      const _AnimatedNotifyButton(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              info.kicker.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                letterSpacing: 2.5,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              info.modelName,
                              style: const TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.w300,
                                height: 1,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            StatusChip(text: info.statusText),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      _AnimatedBatteryBadge(percent: info.batteryPercent),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: FractionallySizedBox(
                        heightFactor: 0.85,
                        widthFactor: 1,
                        child: _MyCarSpecsContainer(info: info),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MyCarSpecsContainer extends StatefulWidget {
  const _MyCarSpecsContainer({required this.info});

  final MyCarInfo info;

  @override
  State<_MyCarSpecsContainer> createState() => _MyCarSpecsContainerState();
}

class _MyCarSpecsContainerState extends State<_MyCarSpecsContainer> {
  static const _switchDuration = Duration(milliseconds: 580);

  MyCarSection? _opened;

  @override
  void didUpdateWidget(covariant _MyCarSpecsContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.info != widget.info) {
      _opened = null;
    }
  }

  void _open(MyCarSection section) => setState(() => _opened = section);

  void _close() => setState(() => _opened = null);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.12),
          ),
        ),
        child: AnimatedSwitcher(
          duration: _switchDuration,
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              fit: StackFit.expand,
              alignment: Alignment.topCenter,
              children: [
                ...previousChildren,
                ?currentChild,
              ],
            );
          },
          transitionBuilder: (child, animation) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.08),
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
          child: _opened == null
              ? KeyedSubtree(
                  key: const ValueKey<String>('sections'),
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 24),
                    itemCount: widget.info.sections.length,
                    separatorBuilder: (_, _) => Divider(
                      height: 1,
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                    itemBuilder: (context, index) {
                      final section = widget.info.sections[index];
                      return _MyCarSectionTile(
                        section: section,
                        onTap: () => _open(section),
                      );
                    },
                  ),
                )
              : KeyedSubtree(
                  key: ValueKey<String>(_opened!.title),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _close,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6, 10, 14, 6),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 18,
                                  color: Colors.white.withValues(alpha: 0.9),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    _opened!.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(14, 4, 14, 24),
                          itemCount: _opened!.stats.length,
                          separatorBuilder: (_, _) => Divider(
                            height: 1,
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                          itemBuilder: (context, index) {
                            return MyCarStatRow(stat: _opened!.stats[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class _MyCarSectionTile extends StatelessWidget {
  const _MyCarSectionTile({
    required this.section,
    required this.onTap,
  });

  final MyCarSection section;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      section.subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        height: 1.3,
                        color: Colors.white.withValues(alpha: 0.72),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                size: 26,
                color: Colors.white.withValues(alpha: 0.45),
              ),
            ],
          ),
        ),
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
