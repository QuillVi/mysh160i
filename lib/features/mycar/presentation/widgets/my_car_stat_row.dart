import 'package:flutter/material.dart';
import 'package:mymotorcycle/features/mycar/domain/entities/my_car_info.dart';

class MyCarStatRow extends StatelessWidget {
  const MyCarStatRow({
    super.key,
    required this.stat,
    this.showChevron = false,
  });

  final MyCarStat stat;
  final bool showChevron;

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
          if (showChevron) ...[
            const SizedBox(width: 6),
            Icon(
              Icons.chevron_right_outlined,
              size: 18,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ],
        ],
      ),
    );
  }
}
