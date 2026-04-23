import 'package:mymotorcycle/features/map/domain/entities/map_info.dart';
import 'package:mymotorcycle/features/map/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  @override
  MapInfo getMapInfo() {
    return const MapInfo(
      greeting: 'Hello, Shinn',
      kicker: 'MAP',
      modelName: 'Navigation',
      statusText: 'Google Maps integration ready',
      batteryPercent: 80,
      weather: 'Sunny',
      temperatureC: 28,
      stats: [
        MapStat(label: 'Current position', value: 'Not connected yet'),
        MapStat(label: 'Destination', value: 'Select on map'),
        MapStat(label: 'ETA', value: '-'),
        MapStat(label: 'Traffic', value: '-'),
        MapStat(label: 'Map provider', value: 'Google Maps (planned)'),
        MapStat(label: 'Notes', value: 'API key and package pending setup.'),
      ],
    );
  }
}
