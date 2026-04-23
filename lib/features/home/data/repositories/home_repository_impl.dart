import 'package:mymotorcycle/features/home/domain/entities/home_dashboard.dart';
import 'package:mymotorcycle/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  HomeDashboard getDashboard() {
    return const HomeDashboard(
      greeting: 'Hello, Shinn',
      modelName: 'SH 160i',
      readyText: 'Ready to drive',
      batteryPercent: 80,
      temperature: 28,
      weather: 'Sunny',
    );
  }
}
