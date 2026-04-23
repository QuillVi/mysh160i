import 'package:mymotorcycle/features/setting/domain/entities/setting_info.dart';
import 'package:mymotorcycle/features/setting/domain/repositories/setting_repository.dart';

class GetSettingInfo {
  const GetSettingInfo(this.repository);

  final SettingRepository repository;

  SettingInfo call() => repository.getSettingInfo();
}
