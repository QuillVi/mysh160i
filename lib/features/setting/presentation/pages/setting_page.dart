import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymotorcycle/core/constants/app_colors.dart';
import 'package:mymotorcycle/core/widgets/circle_icon_button.dart';
import 'package:mymotorcycle/features/setting/domain/entities/setting_info.dart';
import 'package:mymotorcycle/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:mymotorcycle/features/home/presentation/widgets/battery_badge.dart';

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
                    info.headline,
                    style: const TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.w300,
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
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
                                  56,
                                  14,
                                  96,
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
                        Positioned(
                          left: 12,
                          top: 14,
                          child: BatteryBadge(percent: info.batteryPercent),
                        ),
                        Positioned(
                          left: 14,
                          bottom: 14,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                info.weather.toUpperCase(),
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
                                    '${info.temperatureC}',
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
