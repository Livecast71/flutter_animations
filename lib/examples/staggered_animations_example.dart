import 'package:flutter/material.dart';

class StaggeredAnimationsExample extends StatefulWidget {
  const StaggeredAnimationsExample({super.key});

  @override
  State<StaggeredAnimationsExample> createState() => _StaggeredAnimationsExampleState();
}

class _StaggeredAnimationsExampleState extends State<StaggeredAnimationsExample>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      5,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
    );

    _slideAnimations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOut,
        ),
      );
    }).toList();

    _fadeAnimations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOut,
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startStaggeredAnimation() {
    if (_isAnimating) {
      // Reverse animation
      for (int i = _controllers.length - 1; i >= 0; i--) {
        Future.delayed(
          Duration(milliseconds: (4 - i) * 100),
          () => _controllers[i].reverse(),
        );
      }
      _isAnimating = false;
    } else {
      // Forward animation
      for (int i = 0; i < _controllers.length; i++) {
        Future.delayed(
          Duration(milliseconds: i * 100),
          () => _controllers[i].forward(),
        );
      }
      _isAnimating = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staggered Animations'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              title: 'Sequential Slide-In',
              description: 'Items appear one after another',
              child: Column(
                children: List.generate(5, (index) {
                  return SlideTransition(
                    position: _slideAnimations[index],
                    child: FadeTransition(
                      opacity: _fadeAnimations[index],
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: [
                            Colors.blue,
                            Colors.purple,
                            Colors.orange,
                            Colors.green,
                            Colors.pink,
                          ][index],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 30,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Item ${index + 1}',
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
                }),
              ),
            ),
            const SizedBox(height: 30),
            _buildSection(
              title: 'Wave Animation',
              description: 'Watch the wave effect',
              child: SizedBox(
                height: 200,
                child: _WaveAnimation(),
              ),
            ),
            const SizedBox(height: 30),
            _buildSection(
              title: 'Card Stack',
              description: 'Cards appear in sequence',
              child: SizedBox(
                height: 300,
                child: _CardStack(),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _startStaggeredAnimation,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                ),
                child: Text(_isAnimating ? 'Reverse' : 'Animate'),
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

class _WaveAnimation extends StatefulWidget {
  @override
  State<_WaveAnimation> createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<_WaveAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      5,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
      )..repeat(reverse: true),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 20, end: 100).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(5, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 30,
              height: _animations[index].value,
              decoration: BoxDecoration(
                color: [
                  Colors.blue,
                  Colors.purple,
                  Colors.orange,
                  Colors.green,
                  Colors.pink,
                ][index],
                borderRadius: BorderRadius.circular(4),
              ),
            );
          },
        );
      }),
    );
  }
}

class _CardStack extends StatefulWidget {
  @override
  State<_CardStack> createState() => _CardStackState();
}

class _CardStackState extends State<_CardStack> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ),
    );

    _animations = _controllers.asMap().entries.map((entry) {
      final index = entry.key;
      final controller = entry.value;
      return Tween<Offset>(
        begin: Offset(0, 1 + (index * 0.1)),
        end: Offset(0, index * 0.05),
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOut,
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleCards() {
    setState(() {
      _isVisible = !_isVisible;
    });

    if (_isVisible) {
      for (int i = 0; i < _controllers.length; i++) {
        Future.delayed(
          Duration(milliseconds: i * 150),
          () => _controllers[i].forward(),
        );
      }
    } else {
      for (int i = _controllers.length - 1; i >= 0; i--) {
        Future.delayed(
          Duration(milliseconds: (2 - i) * 150),
          () => _controllers[i].reverse(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: List.generate(3, (index) {
                return SlideTransition(
                  position: _animations[index],
                  child: Transform.scale(
                    scale: 1 - (index * 0.1),
                    child: Container(
                      width: 200,
                      height: 150,
                      decoration: BoxDecoration(
                        color: [
                          Colors.blue,
                          Colors.purple,
                          Colors.orange,
                        ][index],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Card ${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _toggleCards,
            child: Text(_isVisible ? 'Hide Cards' : 'Show Cards'),
          ),
        ],
      ),
    );
  }
}

