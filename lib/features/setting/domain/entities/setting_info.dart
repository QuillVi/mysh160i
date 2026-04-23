import 'package:equatable/equatable.dart';

class SettingItem extends Equatable {
  const SettingItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.isToggle = false,
    this.initialOn = false,
  });

  final String id;
  final String title;
  final String? subtitle;
  final bool isToggle;
  final bool initialOn;

  @override
  List<Object?> get props => [id, title, subtitle, isToggle, initialOn];
}

class SettingInfo extends Equatable {
  const SettingInfo({
    required this.greeting,
    required this.kicker,
    required this.headline,
    required this.batteryPercent,
    required this.weather,
    required this.temperatureC,
    required this.items,
  });

  final String greeting;
  final String kicker;
  final String headline;
  final int batteryPercent;
  final String weather;
  final int temperatureC;
  final List<SettingItem> items;

  @override
  List<Object?> get props => [
        greeting,
        kicker,
        headline,
        batteryPercent,
        weather,
        temperatureC,
        items,
      ];
}
