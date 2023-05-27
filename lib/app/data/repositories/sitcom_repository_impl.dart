import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/data/datasources/database_datasource.dart';
import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:epguides_notifier_app/app/domain/repositories/sitcom_repository.dart';

class SitcomRepositoryImpl implements SitcomRepository {
  final DatabaseDatasource datasource;

  SitcomRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<Sitcom>>> getSitcoms() async {
    try {
      final result = await datasource.getSitcoms();
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      log('Generic error exception on get sitcoms');
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<Failure, bool>> saveSitcom(Sitcom sitcom) async {
    try {
      final result = await datasource.saveSitcom(sitcom);
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      log('Generic error exception on save sitcom', error: e);
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<Failure, bool>> removeSitcom(Sitcom sitcom) async {
    try {
      final result = await datasource.removeSitcom(sitcom);
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      log('Generic error exception on remove sitcom', error: e);
      return Left(DatasourceError());
    }
  }
}
