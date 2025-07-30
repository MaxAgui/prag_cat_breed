import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/cat_breeds_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1A2A3A), // azul oscuro
        scaffoldBackgroundColor: const Color(
          0xFF0D1117,
        ), // fondo general oscuro
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF2F81F7), // azul brillante (para botones, acciones)
          secondary: Color(0xFF586069), // gris claro
          onPrimary: Colors.white, // texto sobre primario
          surface: Color(0xFF161B22), // tarjetas o superficies
        ),
      ),
      home: const CatBreedsScreen(),
    );
  }
}
