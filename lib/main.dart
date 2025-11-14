import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/screens/cat_breeds_screen.dart';
import 'package:prag_cat_breed/theme/app_theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Breeds',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const CatBreedsScreen(),
    );
  }
}
