import 'package:mymotorcycle/features/map/domain/entities/map_info.dart';
import 'package:mymotorcycle/features/map/domain/repositories/map_repository.dart';

class GetMapInfo {
  const GetMapInfo(this.repository);

  final MapRepository repository;

  MapInfo call() => repository.getMapInfo();
}
