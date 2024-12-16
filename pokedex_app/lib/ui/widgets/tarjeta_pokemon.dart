// lib/ui/widgets/tarjeta_pokemon.dart
import 'package:flutter/material.dart';
import 'package:pokedex_app/modelos/pokemon.dart';

class TarjetaPokemon extends StatelessWidget {
  final Pokemon pokemon;

  const TarjetaPokemon({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _getColorsByType(pokemon.tipo),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: pokemon.id,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    pokemon.imagenUrl,
                    height: 180,
                    width: 180,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const CircularProgressIndicator();
                    },
                    errorBuilder: (context, error, stackTrace) => 
                        const Icon(Icons.error, size: 80),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                pokemon.nombre.toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              _buildInfoChip('Tipo: ${pokemon.tipo}'),
              _buildInfoChip('Altura: ${pokemon.altura} dm'),
              _buildInfoChip('Peso: ${pokemon.peso} hg'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  List<Color> _getColorsByType(String type) {
    switch (type.toLowerCase()) {
      case 'fuego':
        return [Colors.red, Colors.orange];
      case 'agua':
        return [Colors.blue, Colors.lightBlue];
      case 'planta':
        return [Colors.green, Colors.lightGreen];
      case 'eléctrico':
        return [Colors.yellow, Colors.amber];
      default:
        return [Colors.grey, Colors.blueGrey];
    }
  }
}