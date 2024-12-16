import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pokedex_app/modelos/pokemon.dart';

class AlmacenamientoServicio {
  static const String _key = 'pokemones_guardados';

  Future<List<Pokemon>> obtenerPokemonesGuardados() async {
    final prefs = await SharedPreferences.getInstance();
    final String? pokemonesJson = prefs.getString(_key);
    if (pokemonesJson != null) {
      final List<dynamic> decodedList = json.decode(pokemonesJson);
      return decodedList.map((item) => Pokemon.fromJson(item)).toList();
    }
    return [];
  }

  Future<void> guardarPokemon(Pokemon pokemon) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Pokemon> pokemonesActuales = await obtenerPokemonesGuardados();

    // Verificar si el Pokémon ya existe
    if (!pokemonesActuales.any((p) => p.id == pokemon.id)) {
      pokemonesActuales.add(pokemon);
      await prefs.setString(_key, json.encode(pokemonesActuales.map((p) => p.toJson()).toList()));
    } else {
      print('El Pokémon ya está guardado.');
    }
  }

  Future<void> actualizarPokemon(Pokemon pokemon) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Pokemon> pokemonesActuales = await obtenerPokemonesGuardados();
    final index = pokemonesActuales.indexWhere((p) => p.id == pokemon.id);
    if (index != -1) {
      pokemonesActuales[index] = pokemon;
      await prefs.setString(_key, json.encode(pokemonesActuales.map((p) => p.toJson()).toList()));
    }
  }

  Future<void> eliminarPokemon(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Pokemon> pokemonesActuales = await obtenerPokemonesGuardados();
    pokemonesActuales.removeWhere((p) => p.id == id);
    await prefs.setString(_key, json.encode(pokemonesActuales.map((p) => p.toJson()).toList()));
  }
}