import 'package:equatable/equatable.dart';

class DetailInfo extends Equatable {
  const DetailInfo(this.title);

  final String title;

  @override
  List<Object?> get props => [title];
}
