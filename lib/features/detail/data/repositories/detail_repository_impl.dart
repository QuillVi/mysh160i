import 'package:mymotorcycle/features/detail/domain/entities/detail_info.dart';
import 'package:mymotorcycle/features/detail/domain/repositories/detail_repository.dart';

class DetailRepositoryImpl implements DetailRepository {
  @override
  DetailInfo getDetailInfo() => const DetailInfo('Detail');
}
