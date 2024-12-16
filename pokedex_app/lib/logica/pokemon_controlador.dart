import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_app/modelos/pokemon.dart';
import 'package:pokedex_app/servicios/api_servicio.dart';
import 'package:pokedex_app/servicios/almacenamiento_servicio.dart';

// Estados
abstract class PokemonEstado {}

class PokemonInicial extends PokemonEstado {}
class PokemonCargando extends PokemonEstado {}
class PokemonCargado extends PokemonEstado {
  final Pokemon pokemon;
  PokemonCargado(this.pokemon);
}
class PokemonError extends PokemonEstado {
  final String mensaje;
  PokemonError(this.mensaje);
}

// Eventos
abstract class PokemonEvento {}

class BuscarPokemon extends PokemonEvento {
  final String busqueda;
  BuscarPokemon(this.busqueda);
}

class GuardarPokemon extends PokemonEvento {
  final Pokemon pokemon;
  GuardarPokemon(this.pokemon);
}

// Bloc
class PokemonBloc extends Bloc<PokemonEvento, PokemonEstado> {
  final _apiServicio = GetIt.instance<ApiServicio>();
  final _almacenamientoServicio = GetIt.instance<AlmacenamientoServicio>();

  PokemonBloc() : super(PokemonInicial()) {
    on<BuscarPokemon>(_onBuscarPokemon);
    on<GuardarPokemon>(_onGuardarPokemon);
  }

  Future<void> _onBuscarPokemon(BuscarPokemon evento, Emitter<PokemonEstado> emit) async {
    emit(PokemonCargando());
    try {
      final pokemon = await _apiServicio.buscarPokemon(evento.busqueda.toLowerCase());
      emit(PokemonCargado(pokemon));
    } catch (e) {
      emit(PokemonError('No se pudo encontrar el Pokémon'));
    }
  }

  Future<void> _onGuardarPokemon(GuardarPokemon evento, Emitter<PokemonEstado> emit) async {
    try {
      await _almacenamientoServicio.guardarPokemon(evento.pokemon);
    } catch (e) {
      emit(PokemonError('Error al guardar el Pokémon'));
    }
  }
}