import 'package:mymotorcycle/features/mycar/domain/entities/my_car_info.dart';
import 'package:mymotorcycle/features/mycar/domain/repositories/my_car_repository.dart';

class GetMyCarInfo {
  const GetMyCarInfo(this.repository);

  final MyCarRepository repository;

  MyCarInfo call() => repository.getMyCarInfo();
}
