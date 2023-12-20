import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_card_widget.dart';

class PesronsList extends StatelessWidget {
  final scrollController = ScrollController();
  PesronsList({super.key});

  void setupScrollControoler(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          // BlocProvider.of<PersonListCubit>(context).loadPerson();
          context.read<PersonListCubit>().loadPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollControoler(context);
    return BlocBuilder<PersonListCubit, PersonState>(
      builder: (context, state) {
        List<PersonEntity> persons = [];
        bool isLoading = false;
        if (state is PersonLoading && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonLoading) {
          persons = state.oldPersonsList;
          isLoading = true;
        } else if (state is PersonLoaded) {
          persons = state.loadedPersonList;
        } else if (state is PersonError) {
          return Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PesronsList(),
                    ));
              },
              child: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          );
        }
        return ListView.separated(
          controller: scrollController,
          itemCount: persons.length + (isLoading ? 1 : 0),
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey[400],
            thickness: 2.0,
          ),
          itemBuilder: (context, index) {
            if (index < persons.length) {
              return PersonCard(person: persons[index]);
            } else {
              Timer(const Duration(milliseconds: 300), () {
                if (scrollController.hasClients) {
                  scrollController.jumpTo(
                    scrollController.position.maxScrollExtent,
                  );
                }
              });
              return _loadingIndicator();
            }
          },
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
