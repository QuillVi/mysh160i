import 'package:mymotorcycle/features/setting/domain/entities/setting_info.dart';
import 'package:mymotorcycle/features/setting/domain/repositories/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  @override
  SettingInfo getSettingInfo() => const SettingInfo('Setting');
}
