import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmortyapp/providers/index.dart';
import 'package:rickandmortyapp/widgets/widgets.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  CharactersScreenState createState() => CharactersScreenState();
}

class CharactersScreenState extends State<CharactersScreen> {
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
    final provider = Provider.of<CharactersProvider>(context, listen: false);

    if (provider.characters.isEmpty && !provider.isLoading && !_isLoading) {
      _isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        provider.getCharacters();
        _isLoading = false;
      });
    }
  }

  void _scrollListener() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll * 0.8) {
      final provider = Provider.of<CharactersProvider>(context, listen: false);
      if (!provider.isLoading && provider.hasMore) {
        provider.getMoreCharacters();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final charactersProvider = Provider.of<CharactersProvider>(context);

    return SafeArea(
      child: charactersProvider.characters.isEmpty && charactersProvider.isLoading ?
        const Center(
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
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        )
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}