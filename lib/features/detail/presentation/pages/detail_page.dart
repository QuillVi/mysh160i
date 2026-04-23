import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymotorcycle/core/constants/app_colors.dart';
import 'package:mymotorcycle/core/widgets/circle_icon_button.dart';
import 'package:mymotorcycle/features/detail/domain/entities/detail_info.dart';
import 'package:mymotorcycle/features/detail/presentation/cubit/detail_cubit.dart';
import 'package:mymotorcycle/features/home/presentation/widgets/battery_badge.dart';
import 'package:mymotorcycle/features/home/presentation/widgets/status_chip.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailCubit, DetailState>(
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
                                itemCount: info.stats.length,
                                separatorBuilder: (_, _) => Divider(
                                  height: 1,
                                  color: Colors.white.withValues(alpha: 0.12),
                                ),
                                itemBuilder: (context, index) {
                                  return _DetailStatRow(stat: info.stats[index]);
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

class _DetailStatRow extends StatelessWidget {
  const _DetailStatRow({required this.stat});

  final DetailStat stat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              stat.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              stat.value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Icon(
            Icons.chevron_right_outlined,
            size: 18,
            color: Colors.white.withValues(alpha: 0.5),
            weight: 300,
          ),
        ],
      ),
    );
  }
}
