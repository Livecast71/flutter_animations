import 'package:flutter/material.dart';

class HeroAnimationsExample extends StatelessWidget {
  const HeroAnimationsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animations'),
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          final colors = [
            Colors.blue,
            Colors.purple,
            Colors.orange,
            Colors.green,
            Colors.pink,
            Colors.teal,
          ];
          final icons = [
            Icons.star,
            Icons.favorite,
            Icons.thumb_up,
            Icons.celebration,
            Icons.emoji_events,
            Icons.diamond,
          ];
          final titles = [
            'Star',
            'Heart',
            'Like',
            'Party',
            'Trophy',
            'Diamond',
          ];

          return _HeroCard(
            color: colors[index],
            icon: icons[index],
            title: titles[index],
            heroTag: 'hero_$index',
          );
        },
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String heroTag;

  const _HeroCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _DetailScreen(
              color: color,
              icon: icon,
              title: title,
              heroTag: heroTag,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color,
                color.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: heroTag,
                child: Icon(
                  icon,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailScreen extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String heroTag;

  const _DetailScreen({
    required this.color,
    required this.icon,
    required this.title,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color,
              color.withOpacity(0.3),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: heroTag,
                child: Icon(
                  icon,
                  size: 150,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'This is a Hero animation example. Notice how the icon smoothly transitions from the grid to this detail screen.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
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

