import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymotorcycle/features/home/domain/usecases/get_home_dashboard.dart';
import 'package:mymotorcycle/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getHomeDashboard) : super(const HomeState());

  final GetHomeDashboard _getHomeDashboard;

  void loadDashboard() {
    emit(state.copyWith(dashboard: _getHomeDashboard()));
  }

  void changeTab(int index) {
    emit(state.copyWith(selectedTab: index));
  }
}
