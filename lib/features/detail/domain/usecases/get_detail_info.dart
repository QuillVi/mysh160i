import 'package:mymotorcycle/features/detail/domain/entities/detail_info.dart';
import 'package:mymotorcycle/features/detail/domain/repositories/detail_repository.dart';

class GetDetailInfo {
  const GetDetailInfo(this.repository);

  final DetailRepository repository;

  DetailInfo call() => repository.getDetailInfo();
}
