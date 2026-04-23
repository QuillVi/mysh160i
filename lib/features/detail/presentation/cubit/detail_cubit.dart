import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymotorcycle/features/detail/domain/entities/detail_info.dart';
import 'package:mymotorcycle/features/detail/domain/usecases/get_detail_info.dart';

class DetailState extends Equatable {
  const DetailState({this.info});

  final DetailInfo? info;

  @override
  List<Object?> get props => [info];
}

class DetailCubit extends Cubit<DetailState> {
  DetailCubit(this._getDetailInfo) : super(const DetailState()) {
    load();
  }

  final GetDetailInfo _getDetailInfo;

  void load() => emit(DetailState(info: _getDetailInfo()));
}
