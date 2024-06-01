import 'package:flutter/material.dart';
import '../examples/implicit_animations_example.dart';
import '../examples/explicit_animations_example.dart';
import '../examples/hero_animations_example.dart';
import '../examples/physics_animations_example.dart';
import '../examples/staggered_animations_example.dart';
import '../examples/transform_animations_example.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final examples = [
      AnimationExample(
        title: 'Implicit Animations',
        description: 'AnimatedContainer, AnimatedOpacity, AnimatedPositioned',
        icon: Icons.auto_awesome,
        color: Colors.blue,
        screen: const ImplicitAnimationsExample(),
      ),
      AnimationExample(
        title: 'Explicit Animations',
        description: 'AnimationController with custom curves and tweens',
        icon: Icons.animation,
        color: Colors.purple,
        screen: const ExplicitAnimationsExample(),
      ),
      AnimationExample(
        title: 'Hero Animations',
        description: 'Smooth transitions between screens',
        icon: Icons.flight_takeoff,
        color: Colors.orange,
        screen: const HeroAnimationsExample(),
      ),
      AnimationExample(
        title: 'Physics Animations',
        description: 'Spring, gravity, and friction effects',
        icon: Icons.science,
        color: Colors.green,
        screen: const PhysicsAnimationsExample(),
      ),
      AnimationExample(
        title: 'Staggered Animations',
        description: 'Sequential animations with delays',
        icon: Icons.view_carousel,
        color: Colors.pink,
        screen: const StaggeredAnimationsExample(),
      ),
      AnimationExample(
        title: 'Transform Animations',
        description: 'Rotation, scale, and translation effects',
        icon: Icons.transform,
        color: Colors.teal,
        screen: const TransformAnimationsExample(),
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.secondaryContainer,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      'Flutter Animation',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Explore the possibilities',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: examples.length,
                  itemBuilder: (context, index) {
                    return _AnimationCard(
                      example: examples[index],
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimationExample {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Widget screen;

  AnimationExample({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.screen,
  });
}

class _AnimationCard extends StatelessWidget {
  final AnimationExample example;
  final int index;

  const _AnimationCard({
    required this.example,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => example.screen),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: example.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    example.icon,
                    color: example.color,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        example.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        example.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

