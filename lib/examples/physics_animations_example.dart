import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class PhysicsAnimationsExample extends StatefulWidget {
  const PhysicsAnimationsExample({super.key});

  @override
  State<PhysicsAnimationsExample> createState() => _PhysicsAnimationsExampleState();
}

class _PhysicsAnimationsExampleState extends State<PhysicsAnimationsExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startSpringAnimation() {
    final spring = SpringDescription(
      mass: 1,
      stiffness: 100,
      damping: 10,
    );

    final simulation = SpringSimulation(spring, 0, 1, 0);

    _animation = _controller.drive(
      Tween<double>(begin: 0, end: 300),
    );

    _controller.animateWith(simulation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics Animations'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              title: 'Spring Animation',
              description: 'Tap to see spring physics in action',
              child: SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 4,
                        color: Colors.grey[300],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, -_controller.value * 300),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.5),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.arrow_upward,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _controller.reset();
                              _startSpringAnimation();
                            },
                            child: const Text('Launch Spring'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildSection(
              title: 'Gravity Simulation',
              description: 'Drag and release to see gravity',
              child: SizedBox(
                height: 400,
                child: _GravityBall(),
              ),
            ),
            const SizedBox(height: 30),
            _buildSection(
              title: 'Friction Animation',
              description: 'Swipe to see friction effects',
              child: SizedBox(
                height: 200,
                child: _FrictionBox(),
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

class _GravityBall extends StatefulWidget {
  @override
  State<_GravityBall> createState() => _GravityBallState();
}

class _GravityBallState extends State<_GravityBall>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dropBall() {
    final gravity = GravitySimulation(
      500.0, // acceleration
      0.0, // starting position
      400.0, // ending position
      0.0, // starting velocity
    );

    _animation = _controller.drive(
      Tween<double>(begin: 0, end: 400),
    );

    _controller.animateWith(gravity);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _dropBall,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 4,
                color: Colors.grey[400],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _controller.value * 400 - 200),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.circle,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Tap to drop',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FrictionBox extends StatefulWidget {
  @override
  State<_FrictionBox> createState() => _FrictionBoxState();
}

class _FrictionBoxState extends State<_FrictionBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _position = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _swipe(double velocity) {
    final friction = FrictionSimulation(0.5, _position, velocity);
    final animation = _controller.drive(
      Tween<double>(begin: _position, end: 200),
    );

    _controller.animateWith(friction).then((_) {
      setState(() {
        _position = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        _swipe(details.velocity.pixelsPerSecond.dx);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_position + (_controller.value * 200 - _position), 0),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Swipe left or right',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

