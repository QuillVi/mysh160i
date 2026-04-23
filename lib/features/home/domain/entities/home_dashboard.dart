import 'package:equatable/equatable.dart';

class HomeDashboard extends Equatable {
  const HomeDashboard({
    required this.greeting,
    required this.modelName,
    required this.readyText,
    required this.batteryPercent,
    required this.temperature,
    required this.weather,
  });

  final String greeting;
  final String modelName;
  final String readyText;
  final int batteryPercent;
  final int temperature;
  final String weather;

  @override
  List<Object?> get props => [
        greeting,
        modelName,
        readyText,
        batteryPercent,
        temperature,
        weather,
      ];
}
