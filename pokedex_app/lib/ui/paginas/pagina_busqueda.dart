// lib/ui/paginas/pagina_busqueda.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/logica/pokemon_controlador.dart';
import 'package:pokedex_app/ui/widgets/formulario_busqueda.dart';
import 'package:pokedex_app/ui/widgets/tarjeta_pokemon.dart';

class PaginaBusqueda extends StatelessWidget {
  const PaginaBusqueda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Buscar Pokémon'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const FormularioBusqueda(),
                const SizedBox(height: 20),
                BlocBuilder<PokemonBloc, PokemonEstado>(
                  builder: (context, state) {
                    if (state is PokemonCargando) {
                      return const CircularProgressIndicator();
                    } else if (state is PokemonCargado) {
                      return Column(
                        children: [
                          TarjetaPokemon(pokemon: state.pokemon),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              context.read<PokemonBloc>().add(GuardarPokemon(state.pokemon));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${state.pokemon.nombre} guardado')),
                              );
                            },
                            child: const Text('Guardar Pokémon'),
                          ),
                        ],
                      );
                    } else if (state is PokemonError) {
                      return Text(state.mensaje, style: TextStyle(color: Colors.red));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}