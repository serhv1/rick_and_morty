// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object?> get props => [];
}

class PersonEmpty extends PersonState {
  @override
  List<Object?> get props => [];
}

class PersonLoading extends PersonState {
  final List<PersonEntity> oldPersonsList;
  final bool isFirstFetch;

  const PersonLoading(
    this.oldPersonsList, {
    required this.isFirstFetch,
  });

  @override
  List<Object?> get props => [oldPersonsList];
}

class PersonLoaded extends PersonState {
  final List<PersonEntity> loadedPersonList;

  const PersonLoaded(this.loadedPersonList);
  @override
  List<Object?> get props => [loadedPersonList];
}

class PersonError extends PersonState {
  final String message;

  const PersonError({required this.message});

  @override
  List<Object?> get props => [message];
}
