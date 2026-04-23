import 'package:mymotorcycle/features/home/domain/entities/home_dashboard.dart';
import 'package:mymotorcycle/features/home/domain/repositories/home_repository.dart';

class GetHomeDashboard {
  const GetHomeDashboard(this.repository);

  final HomeRepository repository;

  HomeDashboard call() => repository.getDashboard();
}
