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
        MyCarStat(label: 'Engine', value: 'eSP+ 156.9cc, 4-valve'),
        MyCarStat(label: 'Power', value: '12.4 kW @ 8,500 rpm'),
        MyCarStat(label: 'Torque', value: '14.8 Nm @ 6,500 rpm'),
        MyCarStat(label: 'Fuel system', value: 'PGM-FI electronic injection'),
        MyCarStat(label: 'Fuel tank', value: '7.8 L'),
        MyCarStat(label: 'ABS', value: 'Single-channel (front wheel)'),
        MyCarStat(label: 'Weight', value: '133 kg'),
        MyCarStat(label: 'Connectivity', value: 'Honda RoadSync supported'),
      ],
    );
  }
}
