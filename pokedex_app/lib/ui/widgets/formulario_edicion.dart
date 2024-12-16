import 'package:flutter/material.dart';
import 'package:pokedex_app/modelos/pokemon.dart';
import 'package:pokedex_app/servicios/almacenamiento_servicio.dart';
import 'package:get_it/get_it.dart';

class FormularioEdicion extends StatefulWidget {
  final Pokemon pokemon;

  const FormularioEdicion({Key? key, required this.pokemon}) : super(key: key);

  @override
  _FormularioEdicionState createState() => _FormularioEdicionState();
}

class _FormularioEdicionState extends State<FormularioEdicion> {
  late TextEditingController _nombreController;
  late TextEditingController _tipoController;
  late TextEditingController _alturaController;
  late TextEditingController _pesoController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.pokemon.nombre);
    _tipoController = TextEditingController(text: widget.pokemon.tipo);
    _alturaController = TextEditingController(text: widget.pokemon.altura.toString());
    _pesoController = TextEditingController(text: widget.pokemon.peso.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          TextField(
            controller: _tipoController,
            decoration: const InputDecoration(labelText: 'Tipo'),
          ),
          TextField(
            controller: _alturaController,
            decoration: const InputDecoration(labelText: 'Altura'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _pesoController,
            decoration: const InputDecoration(labelText: 'Peso'),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: () async {
              final pokemonActualizado = Pokemon(
                id: widget.pokemon.id,
                nombre: _nombreController.text,
                tipo: _tipoController.text,
                altura: int.parse(_alturaController.text),
                peso: int.parse(_pesoController.text),
                imagenUrl: widget.pokemon.imagenUrl, // Añadimos este parámetro
              );
              await GetIt.instance<AlmacenamientoServicio>().actualizarPokemon(pokemonActualizado);
              Navigator.pop(context);
            },
            child: const Text('Guardar cambios'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _tipoController.dispose();
    _alturaController.dispose();
    _pesoController.dispose();
    super.dispose();
  }
}