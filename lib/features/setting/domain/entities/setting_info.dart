import 'package:equatable/equatable.dart';

class SettingInfo extends Equatable {
  const SettingInfo(this.title);

  final String title;

  @override
  List<Object?> get props => [title];
}
