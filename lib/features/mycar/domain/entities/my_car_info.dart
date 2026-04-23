import 'package:equatable/equatable.dart';

class MyCarStat extends Equatable {
  const MyCarStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  List<Object?> get props => [label, value];
}

class MyCarInfo extends Equatable {
  const MyCarInfo({
    required this.greeting,
    required this.kicker,
    required this.modelName,
    required this.statusText,
    required this.batteryPercent,
    required this.weather,
    required this.temperatureC,
    required this.stats,
  });

  final String greeting;
  final String kicker;
  final String modelName;
  final String statusText;
  final int batteryPercent;
  final String weather;
  final int temperatureC;
  final List<MyCarStat> stats;

  @override
  List<Object?> get props => [
        greeting,
        kicker,
        modelName,
        statusText,
        batteryPercent,
        weather,
        temperatureC,
        stats,
      ];
}
