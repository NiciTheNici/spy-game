import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

class Country {
  final int id;
  final String alpha2;
  final String alpha3;
  final String name;

  Country(
      {required this.id,
      required this.alpha2,
      required this.alpha3,
      required this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      alpha2: json['alpha2'],
      alpha3: json['alpha3'],
      name: json['name'],
    );
  }
}

class CountryData {
  List<Country> _countries = [];

  Future<void> load() async {
    final jsonString = await rootBundle.loadString('assets/countries.json');
    final countriesJson = jsonDecode(jsonString);
    _countries = List<Country>.from(
      countriesJson.map((json) => Country.fromJson(json)),
    );
  }

  Country getRandomCountry() {
    final random = Random();
    final index = random.nextInt(_countries.length);
    return _countries[index];
  }
}
