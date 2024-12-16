import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_app/servicios/api_servicio.dart';
import 'package:pokedex_app/servicios/almacenamiento_servicio.dart';
import 'package:pokedex_app/ui/paginas/pagina_inicio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _configurarDependencias();
  runApp(const MiApp());
}

void _configurarDependencias() {
  GetIt.I.registerLazySingleton(() => ApiServicio());
  GetIt.I.registerLazySingleton(() => AlmacenamientoServicio());
}

class MiApp extends StatelessWidget {
  const MiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PaginaInicio(),
    );
  }
}