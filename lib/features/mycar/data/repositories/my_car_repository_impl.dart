import 'package:mymotorcycle/features/mycar/domain/entities/my_car_info.dart';
import 'package:mymotorcycle/features/mycar/domain/repositories/my_car_repository.dart';

class MyCarRepositoryImpl implements MyCarRepository {
  @override
  MyCarInfo getMyCarInfo() => const MyCarInfo('My Car');
}
