import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmortyapp/providers/characters_provider.dart';
import 'package:rickandmortyapp/widgets/characters/character_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final provider = Provider.of<CharactersProvider>(context, listen: false);
        if (provider.characters.isEmpty && !provider.isLoading) {
          provider.loadCharacters();
        }
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final provider = Provider.of<CharactersProvider>(context, listen: false);
      if (!provider.isLoading) {
        provider.loadMoreCharacters();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final charactersProvider = Provider.of<CharactersProvider>(context);
    return SafeArea(
      child: charactersProvider.characters.isEmpty && charactersProvider.isLoading ?
        Center(
          child: CircularProgressIndicator(),
        ):
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: charactersProvider.characters.length,
                itemBuilder: (context, index) {
                  return CharacterCard(
                    character:  charactersProvider.characters[index],
                  );
                }
              )
            ),
            if (charactersProvider.characters.isNotEmpty && charactersProvider.isLoading)
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        )
    );
  }
}