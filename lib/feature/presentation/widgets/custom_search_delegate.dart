import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty/feature/presentation/widgets/search_result.dart';
import 'dart:developer' as dev;

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate()
      : super(
          searchFieldLabel: 'Search for characters...',
        );
  final _suggestions = [
    'Rick',
    'Morty',
    'Sanchez',
    'Summer',
    'Beth',
    'Jerry',
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: const Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
      ),
      tooltip: 'Back',
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    dev.log('Inside buildResults, query: $query');
    BlocProvider.of<PersonSearchBloc>(context, listen: false).add(
      SearchPersons(
        query,
      ),
    );
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
      builder: (context, state) {
        if (state is PersonSearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PersonSearchLoaded) {
          if (state.persons.isEmpty) {
            return const Text(
              'No characters with that name found',
            );
          }
          return ListView.builder(
            itemCount: state.persons.isNotEmpty ? state.persons.length : 0,
            itemBuilder: (context, index) {
              PersonEntity result = state.persons[index];
              return SearchResult(personResult: result);
            },
          );
        } else if (state is PersonSearchError) {
          return _showErrorText(state.message);
        } else {
          return const Icon(Icons.hourglass_empty);
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return const SizedBox.shrink();
    }
    return ListView.separated(
      padding: const EdgeInsets.all(12.0),
      itemBuilder: (context, index) {
        return Text(
          _suggestions[index],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.blueGrey,
      ),
      itemCount: _suggestions.length,
    );
  }
}

Widget _showErrorText(String errorMessage) {
  return Container(
    color: Colors.black,
    child: Center(
      child: Text(
        errorMessage,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
