import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex_app/modelos/pokemon.dart';

class ApiServicio {
  final String baseUrl = 'https://pokeapi.co/api/v2';

  Future<Pokemon> buscarPokemon(String busqueda) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$busqueda'));
    
    if (response.statusCode == 200) {
      return Pokemon.fromJson(json.decode(response.body));
    } else {
      throw Exception('No se pudo encontrar el Pokémon');
    }
  }
}