import 'package:mymotorcycle/features/setting/domain/entities/setting_info.dart';
import 'package:mymotorcycle/features/setting/domain/repositories/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  @override
  SettingInfo getSettingInfo() {
    return const SettingInfo(
      greeting: 'Hello, Shinn',
      kicker: 'PREFERENCES',
      headline: 'Settings',
      batteryPercent: 80,
      weather: 'Sunny',
      temperatureC: 28,
      items: [
        SettingItem(
          id: 'push',
          title: 'Push notifications',
          subtitle: 'Trip and vehicle alerts',
          isToggle: true,
          initialOn: true,
        ),
        SettingItem(
          id: 'email',
          title: 'Email summary',
          subtitle: 'Weekly usage digest',
          isToggle: true,
          initialOn: false,
        ),
        SettingItem(
          id: 'haptics',
          title: 'Haptic feedback',
          isToggle: true,
          initialOn: true,
        ),
        SettingItem(
          id: 'lang',
          title: 'Language',
          subtitle: 'English',
          isToggle: false,
        ),
        SettingItem(
          id: 'privacy',
          title: 'Privacy policy',
          isToggle: false,
        ),
        SettingItem(
          id: 'about',
          title: 'About this app',
          subtitle: 'Version 1.0.0',
          isToggle: false,
        ),
      ],
    );
  }
}
