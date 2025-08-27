import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:rickandmortyapp/models/models.dart';
import 'package:rickandmortyapp/providers/index.dart';
import 'package:rickandmortyapp/services/services.dart';

class CharacterInfo extends StatefulWidget {
  final Character character;

  const CharacterInfo({Key? key, required this.character }) : super(key: key);

  @override
  _CharacterInfoState createState() => _CharacterInfoState();
}

class _CharacterInfoState extends State<CharacterInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<EpisodeProvider>(context, listen: false);

    if (provider.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        provider.getEpisode(url: widget.character.episode.first);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EpisodeProvider>(context);

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                widget.character.image,
                cacheManager: CustomImageCacheManager(),
              ),
              radius: 100,
            ),
          ),
          ListTile(
            title: Text(widget.character.name, style: TextStyle(fontWeight: FontWeight.w900)),
            subtitle: Text('${widget.character.status} - ${widget.character.species}', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
          ListTile(
            title: Text('Last known location:'),
            subtitle: Text(widget.character.location.name, style: TextStyle(
              fontWeight: FontWeight.w900
            )),
          ),
          if (provider.episode != null && !provider.isLoading)
            ListTile(
              title: Text('First seen in:'),
              subtitle: Text('${provider.episode!.name} (${provider.episode!.episode})', style: TextStyle(
                  fontWeight: FontWeight.w900
              )),
            ),
        ],
      ),
    );
  }
}