import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymotorcycle/features/map/domain/entities/map_info.dart';
import 'package:mymotorcycle/features/map/domain/usecases/get_map_info.dart';

class MapState extends Equatable {
  const MapState({this.info});

  final MapInfo? info;

  @override
  List<Object?> get props => [info];
}

class MapCubit extends Cubit<MapState> {
  MapCubit(this._getMapInfo) : super(const MapState()) {
    load();
  }

  final GetMapInfo _getMapInfo;

  void load() => emit(MapState(info: _getMapInfo()));
}
