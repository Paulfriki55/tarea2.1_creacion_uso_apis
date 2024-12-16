import 'package:flutter/material.dart';
import 'package:pokedex_app/modelos/pokemon.dart';
import 'package:pokedex_app/servicios/almacenamiento_servicio.dart';
import 'package:pokedex_app/ui/widgets/tarjeta_pokemon.dart';
import 'package:pokedex_app/ui/paginas/pagina_edicion_pokemon.dart';
import 'package:get_it/get_it.dart';

class PaginaListaGuardados extends StatefulWidget {
  const PaginaListaGuardados({Key? key}) : super(key: key);

  @override
  _PaginaListaGuardadosState createState() => _PaginaListaGuardadosState();
}

class _PaginaListaGuardadosState extends State<PaginaListaGuardados> {
  final AlmacenamientoServicio _almacenamientoServicio = GetIt.instance<AlmacenamientoServicio>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Guardados'),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: _almacenamientoServicio.obtenerPokemonesGuardados(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay Pokémon guardados'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pokemon = snapshot.data![index];
                return Dismissible(
                  key: Key(pokemon.id.toString()),
                  onDismissed: (direction) async {
                    await _almacenamientoServicio.eliminarPokemon(pokemon.id);
                    setState(() {}); // Forzar reconstrucción del widget
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${pokemon.nombre} eliminado')),
                    );
                  },
                  background: Container(color: Colors.red),
                  child: GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaginaEdicionPokemon(pokemon: pokemon),
                        ),
                      );
                      if (result == true) {
                        setState(() {}); // Forzar reconstrucción del widget si se editó el Pokémon
                      }
                    },
                    child: TarjetaPokemon(pokemon: pokemon),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}