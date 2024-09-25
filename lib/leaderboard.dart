import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:leaderboard/classes.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({
    super.key,
    required this.users,
    required this.qualifiedQuota,
    required this.loadingText,
  });

  final List<User> users;
  final int qualifiedQuota;
  final String loadingText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomListItem(
        users: users,
        quota: qualifiedQuota,
        loadingText: loadingText,
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
    required this.rank,
    required this.quota,
    required this.title,
    required this.subtitle,
    required this.subfooter,
    required this.footer,
    this.image,
  });

  final int rank;
  final int quota;
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
                      SizedBox(
                        width: 45,
                        child: Center(
                          child: Text(
                            rank.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:
                                    rank <= quota ? Colors.green[400] : null),
                          ),
                        ),
                      ),
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

Widget separator() {
  return SizedBox(
    height: 30,
    child: Center(
      child: Text(
        '↑ Qualified! ↑',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.green[400],
        ),
      ),
    ),
  );
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.users,
    required this.quota,
    required this.loadingText,
  });

  final List<User> users;
  final int quota;
  final String loadingText;

  // this is just to open a sub page when tapping/clicking on the widget
  Future<void> displaySubPage(BuildContext context, int index) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SubPage(index: index)));
  }

  @override
  Widget build(BuildContext context) {
    bool showSeparator = users.length > quota;
    int totalItemCount = showSeparator ? users.length + 1 : users.length;
    return totalItemCount == 0
        ? loadingText.isEmpty
            ? const Center(
                child: Text('No data'),
              )
            : Center(
                child: Text(loadingText),
              )
        : Scaffold(
            body: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              physics: const BouncingScrollPhysics(),
              itemCount: totalItemCount,
              itemBuilder: (BuildContext context, int index) {
                if (index == quota) {
                  return separator();
                }
                int playerIndex = index > quota ? index - 1 : index;
                User user = users.elementAt(playerIndex);
                return GestureDetector(
                  child: _Content(
                    quota: quota,
                    rank: (playerIndex + 1),
                    image: Image.network(user.avatar),
                    title: user.name,
                    subtitle: 'Total Score: ${user.qualifierScore}',
                    subfooter: 'aaa',
                    footer: 'bbb',
                  ),
                  onTap: () {
                    displaySubPage(context, index);
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
  final int index;

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
