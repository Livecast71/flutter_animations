import 'package:flutter/material.dart';

class ImplicitAnimationsExample extends StatefulWidget {
  const ImplicitAnimationsExample({super.key});

  @override
  State<ImplicitAnimationsExample> createState() => _ImplicitAnimationsExampleState();
}

class _ImplicitAnimationsExampleState extends State<ImplicitAnimationsExample> {
  bool _isExpanded = false;
  bool _isVisible = true;
  double _left = 0;
  Color _color = Colors.blue;
  double _borderRadius = 8.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animations'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              title: 'AnimatedContainer',
              description: 'Tap to change size, color, and border radius',
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                      _color = _color == Colors.blue
                          ? Colors.purple
                          : _color == Colors.purple
                              ? Colors.orange
                              : Colors.blue;
                      _borderRadius = _borderRadius == 8.0 ? 50.0 : 8.0;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: _isExpanded ? 200 : 100,
                    height: _isExpanded ? 200 : 100,
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: BorderRadius.circular(_borderRadius),
                      boxShadow: [
                        BoxShadow(
                          color: _color.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.touch_app,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildSection(
              title: 'AnimatedOpacity',
              description: 'Toggle visibility with smooth fade',
              child: Column(
                children: [
                  AnimatedOpacity(
                    opacity: _isVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.pink, Colors.purple],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Hello! 👋',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    child: Text(_isVisible ? 'Hide' : 'Show'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildSection(
              title: 'AnimatedPositioned',
              description: 'Tap to move the box',
              child: SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                      left: _left,
                      top: 50,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _left = _left == 0 ? 250 : 0;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.directions_run,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildSection(
              title: 'AnimatedAlign',
              description: 'Watch the alignment change',
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.bounceOut,
                  alignment: _isExpanded
                      ? Alignment.topRight
                      : Alignment.bottomLeft,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.star, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

