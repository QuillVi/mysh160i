import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymotorcycle/features/setting/domain/entities/setting_info.dart';
import 'package:mymotorcycle/features/setting/domain/usecases/get_setting_info.dart';

class SettingState extends Equatable {
  const SettingState({this.info});

  final SettingInfo? info;

  @override
  List<Object?> get props => [info];
}

class SettingCubit extends Cubit<SettingState> {
  SettingCubit(this._getSettingInfo) : super(const SettingState()) {
    load();
  }

  final GetSettingInfo _getSettingInfo;

  void load() => emit(SettingState(info: _getSettingInfo()));
}
