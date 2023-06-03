import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:epguides_notifier_app/app/domain/repositories/sitcom_repository.dart';

abstract class GetSitcomsUsecase {
  Future<Either<Failure, List<Sitcom>>> call();
}

class GetSitcomsUsecaseImpl implements GetSitcomsUsecase {
  final SitcomRepository repository;

  GetSitcomsUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, List<Sitcom>>> call() async {
    return await repository.getSitcoms();
  }
}
