import 'package:bloc/bloc.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/add_sitcom_watchlist_usecase.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/get_sitcoms_usecase.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/remove_sitcoms_usecase.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/sitcom/sitcom_event.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/sitcom/sitcom_state.dart';

class SitcomBloc extends Bloc<SitcomEvent, SitcomState> {
  final AddSitcomWatchListUsecase addSitcomWatchListUsecase;
  final GetSitcomsUsecase getSitcomsUsecase;
  final RemoveSitcomsUsecase removeSitcomsUsecase;

  SitcomBloc({
    required this.addSitcomWatchListUsecase,
    required this.getSitcomsUsecase,
    required this.removeSitcomsUsecase,
  }) : super(StartSicomState()) {
    on<AddSitcomEvent>((event, emit) async {
      final sitcomName = event.sitcomName;

      emit(LoadingSicomState());

      final result = await addSitcomWatchListUsecase(sitcomName);
      final listSitcoms = (await getSitcomsUsecase()).getOrElse(() => []);

      result.fold(
        (failure) => emit(ErrorSicomState(failure)),
        (_) => emit(SucessSicomState(listSitcoms)),
      );
    });

    on<RemoveSitcomEvent>((event, emit) async {
      final sitcom = event.sitcom;

      emit(LoadingSicomState());

      final result = await removeSitcomsUsecase(sitcom);
      final listSitcoms = (await getSitcomsUsecase()).getOrElse(() => []);

      result.fold(
        (failure) => emit(ErrorSicomState(failure)),
        (_) => emit(SucessSicomState(listSitcoms)),
      );
    });

    on<LoadSitcomsEvent>(((event, emit) async {
      final result = await getSitcomsUsecase();

      emit(LoadingSicomState());

      result.fold(
        (failure) => emit(ErrorSicomState(failure)),
        (sucess) => emit(SucessSicomState(sucess)),
      );
    }));
  }
}
