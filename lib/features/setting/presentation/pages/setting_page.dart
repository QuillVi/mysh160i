import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mymotorcycle/core/constants/app_colors.dart';
import 'package:mymotorcycle/features/setting/domain/entities/setting_info.dart';
import 'package:mymotorcycle/features/setting/presentation/cubit/setting_cubit.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Map<String, bool>? _toggleValues;

  void _initTogglesIfNeeded(SettingInfo info) {
    _toggleValues ??= {
      for (final item in info.items.where((e) => e.isToggle))
        item.id: item.initialOn,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        final info = state.info;
        if (info == null) {
          return const Center(child: CircularProgressIndicator());
        }
        _initTogglesIfNeeded(info);

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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              info.headline,
                              style: const TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.w300,
                                height: 1,
                                color: Colors.white,
                              ),
                            ),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.12),
                              ),
                            ),
                            child: ListView.separated(
                              padding: const EdgeInsets.fromLTRB(
                                14,
                                16,
                                14,
                                24,
                              ),
                              itemCount: info.items.length,
                              separatorBuilder: (_, _) => Divider(
                                height: 1,
                                color: Colors.white.withValues(alpha: 0.12),
                              ),
                              itemBuilder: (context, index) {
                                final item = info.items[index];
                                return _SettingItemTile(
                                  item: item,
                                  toggleValue: item.isToggle
                                      ? (_toggleValues![item.id] ?? false)
                                      : null,
                                  onToggle: item.isToggle
                                      ? (value) {
                                          setState(() {
                                            _toggleValues![item.id] = value;
                                          });
                                        }
                                      : null,
                                );
                              },
                            ),
                          ),
                        ),
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

class _SettingItemTile extends StatelessWidget {
  const _SettingItemTile({
    required this.item,
    required this.toggleValue,
    required this.onToggle,
  });

  final SettingItem item;
  final bool? toggleValue;
  final ValueChanged<bool>? onToggle;

  @override
  Widget build(BuildContext context) {
    if (item.isToggle && toggleValue != null && onToggle != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  if (item.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withValues(alpha: 0.65),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Switch(
              value: toggleValue!,
              onChanged: onToggle,
              activeThumbColor: AppColors.neon,
              activeTrackColor: Colors.black,
              inactiveThumbColor: Colors.white70,
              inactiveTrackColor: Colors.white24,
            ),
          ],
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    if (item.subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.white.withValues(alpha: 0.65),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_outlined,
                size: 22,
                color: Colors.white.withValues(alpha: 0.5),
                weight: 300,
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
