// lib/modelos/pokemon.dart
class Pokemon {
  final int id;
  String nombre;
  String tipo;
  int altura;
  int peso;
  String imagenUrl;

  Pokemon({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.altura,
    required this.peso,
    required this.imagenUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('types')) {
      return Pokemon(
        id: json['id'],
        nombre: json['name'],
        tipo: json['types'][0]['type']['name'],
        altura: json['height'],
        peso: json['weight'],
        imagenUrl: json['sprites']['other']['official-artwork']['front_default'],
      );
    }
    return Pokemon(
      id: json['id'],
      nombre: json['nombre'],
      tipo: json['tipo'],
      altura: json['altura'],
      peso: json['peso'],
      imagenUrl: json['imagenUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'tipo': tipo,
      'altura': altura,
      'peso': peso,
      'imagenUrl': imagenUrl,
    };
  }
}