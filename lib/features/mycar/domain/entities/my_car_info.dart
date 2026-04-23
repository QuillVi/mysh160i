import 'package:equatable/equatable.dart';

class MyCarInfo extends Equatable {
  const MyCarInfo(this.title);

  final String title;

  @override
  List<Object?> get props => [title];
}
