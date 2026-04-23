import 'package:flutter/material.dart';
import 'package:mymotorcycle/core/constants/app_colors.dart';

class BatteryBadge extends StatelessWidget {
  const BatteryBadge({required this.percent, super.key});

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
          const Icon(
            Icons.bolt_outlined,
            size: 20,
            color: Colors.black,
            weight: 300,
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
