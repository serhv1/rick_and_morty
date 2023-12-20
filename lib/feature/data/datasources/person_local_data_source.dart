import 'dart:convert';
import 'dart:developer' as dev;
import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future putPersonsToCache(List<PersonModel> persons);
}

const cachedPersonsList = 'CACHED_PERSONS_LIST';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList = sharedPreferences.getStringList(cachedPersonsList);
    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(
        jsonPersonsList
            .map((person) => PersonModel.fromJson(json.decode(person)))
            .toList(),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future putPersonsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();
    sharedPreferences.setStringList(cachedPersonsList, jsonPersonsList);
    dev.log('Persons to write to cache: ${jsonPersonsList.length}');
    return Future.value(jsonPersonsList);
  }
}
