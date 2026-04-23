import 'package:equatable/equatable.dart';
import 'package:mymotorcycle/features/home/domain/entities/home_dashboard.dart';

class HomeState extends Equatable {
  const HomeState({
    this.dashboard,
    this.selectedTab = 0,
  });

  final HomeDashboard? dashboard;
  final int selectedTab;

  HomeState copyWith({
    HomeDashboard? dashboard,
    int? selectedTab,
  }) {
    return HomeState(
      dashboard: dashboard ?? this.dashboard,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object?> get props => [dashboard, selectedTab];
}
