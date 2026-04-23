import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymotorcycle/features/mycar/domain/entities/my_car_info.dart';
import 'package:mymotorcycle/features/mycar/domain/usecases/get_my_car_info.dart';

class MyCarState extends Equatable {
  const MyCarState({this.info});

  final MyCarInfo? info;

  @override
  List<Object?> get props => [info];
}

class MyCarCubit extends Cubit<MyCarState> {
  MyCarCubit(this._getMyCarInfo) : super(const MyCarState()) {
    load();
  }

  final GetMyCarInfo _getMyCarInfo;

  void load() => emit(MyCarState(info: _getMyCarInfo()));
}
