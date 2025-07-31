import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prag_cat_breed/features/cat_breed/application/providers.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/cat_card.dart';
import 'package:prag_cat_breed/features/cat_breed/presentation/lista_cat_cards.dart';

class CatBreedsScreen extends ConsumerStatefulWidget {
  const CatBreedsScreen({super.key});

  @override
  ConsumerState<CatBreedsScreen> createState() => _CatBreedsScreenState();
}

class _CatBreedsScreenState extends ConsumerState<CatBreedsScreen> {
  late final TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    // Cancelar debounce anterior si está activo
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Crear nuevo debounce
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(catSearchQueryProvider.notifier).state = value.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(catSearchQueryProvider);
    final isSearching = searchQuery.isNotEmpty;
    final searchResults = ref.watch(catBreedsSearchProvider(searchQuery));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catbreeds'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Search bar
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                onChanged: _onSearchChanged,
                onSubmitted: (value) {
                  _debounce?.cancel(); // cancelar el debounce si lo hay
                  ref.read(catSearchQueryProvider.notifier).state = value
                      .trim();
                },
                decoration: const InputDecoration(
                  hintText: 'Buscar raza',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Lista
            Expanded(
              child: isSearching
                  ? searchResults.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Center(child: Text('Hubo un error')),
                      data: (results) {
                        if (results.isEmpty) {
                          return const Center(
                            child: Text('No se encontraron razas.'),
                          );
                        }
                        return ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final breed = results[index];
                            return CatCard(
                              breed: breed,
                            );
                          },
                        );
                      },
                    )
                  : ListaCatCards(),
            ),
          ],
        ),
      ),
    );
  }
}
