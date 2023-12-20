import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_state.dart';

const serverFailureMessage = 'Server Failure';

const cacheFailureMessage = 'Cache Failure';

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;

  PersonListCubit({
    required this.getAllPersons,
  }) : super(PersonEmpty());

  int page = 1;

  void loadPerson() async {
    final currentState = state;

    if (currentState is PersonLoading) {
      return;
    }
    var oldPersonList = <PersonEntity>[];
    if (currentState is PersonLoaded) {
      oldPersonList = currentState.loadedPersonList;
    }
    emit(PersonLoading(oldPersonList, isFirstFetch: page == 1));
    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));
    failureOrPerson.fold(
        (error) => emit(PersonError(message: _mapFailureToMessage(error))),
        (character) {
      page++;
      final persons = (state as PersonLoading).oldPersonsList;
      persons.addAll(character);
      emit(PersonLoaded(persons));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
