import 'package:mymotorcycle/features/detail/domain/entities/detail_info.dart';
import 'package:mymotorcycle/features/detail/domain/repositories/detail_repository.dart';

class DetailRepositoryImpl implements DetailRepository {
  @override
  DetailInfo getDetailInfo() {
    return const DetailInfo(
      greeting: 'Hello, Shinn',
      kicker: 'VEHICLE DETAILS',
      modelName: 'SH 160i',
      statusText: 'Ready to drive',
      batteryPercent: 80,
      weather: 'Sunny',
      temperatureC: 28,
      stats: [
        DetailStat(label: 'VIN', value: '—'),
        DetailStat(label: 'Color', value: 'Pearl white'),
        DetailStat(label: 'Odometer', value: '— km'),
        DetailStat(label: 'Last service', value: '—'),
        DetailStat(label: 'Next inspection', value: '—'),
        DetailStat(label: 'Notes', value: 'Replace placeholders when data is available.'),
      ],
    );
  }
}
