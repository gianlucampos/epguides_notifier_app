import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:epguides_notifier_app/app/domain/repositories/sitcom_repository.dart';

abstract class RemoveSitcomsUsecase {
  Future<Either<Failure, bool>> call(Sitcom sitcom);
}

class RemoveSitcomsUsecaseImpl implements RemoveSitcomsUsecase {
  final SitcomRepository repository;

  RemoveSitcomsUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, bool>> call(Sitcom sitcom) async {
    return await repository.removeSitcom(sitcom);
  }
}
