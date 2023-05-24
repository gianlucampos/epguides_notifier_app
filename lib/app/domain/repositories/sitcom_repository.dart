import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';

abstract class SitcomRepository {
  Future<Either<Failure, List<Sitcom>>> getSitcoms();

  Future<Either<Failure, bool>> saveSitcom(Sitcom sitcom);

  Future<Either<Failure, bool>> removeSitcom(Sitcom sitcom);
}
