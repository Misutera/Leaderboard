import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:leaderboard/classes.dart';

class MapPool extends StatelessWidget {
  const MapPool({super.key, required this.songs, required this.qualifiers});

  final Map<String, Song> songs;
  final List<Qualifier> qualifiers;

  Widget topWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: 50,
          child: Row(children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            const Expanded(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Map Pool',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )),
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 800,
          child: Column(
            children: [
              topWidget(context),
              Expanded(
                child: CustomListItem(
                  qualifiers: qualifiers,
                  songs: songs,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    required this.title,
    required this.subtitle,
    required this.subfooter,
    required this.footer,
  });

  final String title;
  final String subtitle;
  final String subfooter;
  final String footer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
        Expanded(
          child: Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16.0,
              //color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.title,
    required this.subtitle,
    required this.subfooter,
    required this.footer,
    this.image,
  });

  final String title;
  final String subtitle;
  final String subfooter;
  final String footer;
  final Image? image;

  Widget imagePic(Image image) {
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 100,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    image: image!.image,
                    fit: BoxFit.cover,
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: SizedBox(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: image ??
                                const Icon(Icons.image_not_supported_outlined),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 5.0, 2.0, 5.0),
                          child: _Description(
                            title: title,
                            subtitle: subtitle,
                            subfooter: subfooter,
                            footer: footer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.songs,
    required this.qualifiers,
  });

  final Map<String, Song> songs;
  final List<Qualifier> qualifiers;

  // this is just to open a sub page when tapping/clicking on the widget
  Future<void> displaySubPage(BuildContext context, String index) async {
    // await Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage(index: index)));
  }

  Song? getSongInfo(String songID) {
    return songs[songID];
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, Song>> songEntries = songs.entries.toList();
    songEntries.sort((a, b) => a.value.id.compareTo(b.value.id));
    qualifiers.sort((a, b) => a.mapID.compareTo(b.mapID));

    int totalItemCount = songs.length;
    return totalItemCount == 0
        ? const Center(
            child: Text('Fetching map data...'),
          )
        : Scaffold(
            body: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              physics: const BouncingScrollPhysics(),
              itemCount: totalItemCount,
              itemBuilder: (BuildContext context, int index) {
                Song song = songEntries[index].value;
                Qualifier qualifier = qualifiers[index];

                String difficulty = qualifier.mapDifficulty == 'ExpertPlus'
                    ? 'Expert+'
                    : qualifier.mapDifficulty;

                return GestureDetector(
                  child: _Content(
                    image: Image.network(song.coverImage),
                    title: song.name,
                    subtitle: 'Difficulty: $difficulty',
                    subfooter: 'aaa',
                    footer: 'bbb',
                  ),
                  onTap: () {
                    displaySubPage(context,
                        'QualifierID: ${qualifier.mapID}, SongID: ${song.id}');
                  },
                );
              },
            ),
          );
  }
}

// TODO: Placeholder Subpage. Implement a proper Subpage.
class SubPage extends StatelessWidget {
  const SubPage({super.key, required this.index});
  final String index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Index: $index'),
      ),
    );
  }
}
