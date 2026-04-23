import 'package:mymotorcycle/features/mycar/domain/entities/my_car_info.dart';
import 'package:mymotorcycle/features/mycar/domain/repositories/my_car_repository.dart';

class MyCarRepositoryImpl implements MyCarRepository {
  @override
  MyCarInfo getMyCarInfo() {
    return const MyCarInfo(
      greeting: 'Hello, Shinn',
      kicker: 'MY GARAGE',
      modelName: 'SH 160i',
      statusText: 'Ready to drive',
      batteryPercent: 80,
      weather: 'Sunny',
      temperatureC: 28,
      stats: [
        MyCarStat(label: 'Role', value: 'Primary vehicle'),
        MyCarStat(label: 'Nickname', value: '—'),
        MyCarStat(label: 'Bluetooth', value: 'Connected'),
        MyCarStat(label: 'Last sync', value: '—'),
        MyCarStat(label: 'Firmware', value: '—'),
        MyCarStat(label: 'Notes', value: 'Connect a backend to show live data.'),
      ],
    );
  }
}
