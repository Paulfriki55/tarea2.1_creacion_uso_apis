import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/logica/pokemon_controlador.dart';

class FormularioBusqueda extends StatefulWidget {
  const FormularioBusqueda({Key? key}) : super(key: key);

  @override
  _FormularioBusquedaState createState() => _FormularioBusquedaState();
}

class _FormularioBusquedaState extends State<FormularioBusqueda> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Buscar Pokémon por nombre o número',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(fontSize: 16),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  context.read<PokemonBloc>().add(BuscarPokemon(value));
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.catching_pokemon),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                context.read<PokemonBloc>().add(BuscarPokemon(_controller.text));
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}