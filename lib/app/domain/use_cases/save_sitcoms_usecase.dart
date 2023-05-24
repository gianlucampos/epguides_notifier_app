import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:epguides_notifier_app/app/domain/repositories/sitcom_repository.dart';

abstract class SaveSitcomsUsecase {
  Future<Either<Failure, bool>> call(Sitcom sitcom);
}

class SaveSitcomsUsecaseImpl implements SaveSitcomsUsecase {
  final SitcomRepository repository;

  SaveSitcomsUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, bool>> call(Sitcom sitcom) async {
    return await repository.saveSitcom(sitcom);
  }
}
