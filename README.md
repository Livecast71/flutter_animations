# Flutter Animation Showcase

A comprehensive Flutter application demonstrating various animation techniques and possibilities. This app serves as a learning resource and reference for implementing animations in Flutter applications.

## 🎨 Overview

This app showcases 6 different categories of animations, each demonstrating unique Flutter animation capabilities:

1. **Implicit Animations** - Simple, declarative animations
2. **Explicit Animations** - Full control with AnimationController
3. **Hero Animations** - Smooth transitions between screens
4. **Physics Animations** - Realistic physics-based motion
5. **Staggered Animations** - Sequential animations with delays
6. **Transform Animations** - Rotation, scale, and 3D effects

## 📱 Getting Started

### Prerequisites

- Flutter SDK (3.10.0 or higher)
- Dart SDK
- iOS Simulator or Android Emulator (or physical device)

### Running the App

```bash
# Get dependencies
flutter pub get

# Run on iOS
flutter run

# Run on Android
flutter run

# Build for iOS
flutter build ios

# Build for Android
flutter build apk
```

## 🎯 Animation Categories Explained

### 1. Implicit Animations

**What they are:** Implicit animations automatically animate between property changes. They're the simplest way to add animations to your Flutter app.

**Key Widgets:**
- `AnimatedContainer` - Animates size, color, padding, decoration, etc.
- `AnimatedOpacity` - Smoothly fades widgets in and out
- `AnimatedPositioned` - Animates position changes
- `AnimatedAlign` - Animates alignment changes

**How they work:**
```dart
// Example: AnimatedContainer
AnimatedContainer(
  duration: const Duration(milliseconds: 500),
  curve: Curves.easeInOut,
  width: _isExpanded ? 200 : 100,
  height: _isExpanded ? 200 : 100,
  decoration: BoxDecoration(
    color: _color,
    borderRadius: BorderRadius.circular(_borderRadius),
  ),
  child: Icon(Icons.touch_app),
)
```

**When to use:**
- Simple property changes (size, color, position)
- Quick animations without complex control
- UI state transitions

**File:** `lib/examples/implicit_animations_example.dart`

---

### 2. Explicit Animations

**What they are:** Explicit animations give you full control over the animation lifecycle using `AnimationController`. You can create custom animations with precise timing and curves.

**Key Components:**
- `AnimationController` - Controls animation timing and state
- `Tween` - Defines the range of values to animate
- `CurvedAnimation` - Applies animation curves (ease, bounce, elastic, etc.)
- `AnimatedBuilder` - Rebuilds widgets during animation

**How they work:**
```dart
// Setup
late AnimationController _controller;
late Animation<double> _animation;

@override
void initState() {
  super.initState();
  _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();
  
  _animation = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ),
  );
}

// Usage
AnimatedBuilder(
  animation: _animation,
  builder: (context, child) {
    return Transform.rotate(
      angle: _animation.value * 2 * 3.14159,
      child: YourWidget(),
    );
  },
)
```

**When to use:**
- Complex animations requiring precise control
- Animations that need to be paused, reversed, or repeated
- Custom animation sequences
- Animations triggered by user interactions

**File:** `lib/examples/explicit_animations_example.dart`

---

### 3. Hero Animations

**What they are:** Hero animations create smooth transitions when navigating between screens. A widget "flies" from one screen to another, creating a seamless visual connection.

**Key Widget:**
- `Hero` - Wraps widgets that should animate between screens

**How they work:**
```dart
// Screen 1: Wrap widget with Hero
Hero(
  tag: 'unique_hero_tag',
  child: Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,
    ),
    child: Icon(Icons.star),
  ),
)

// Screen 2: Use the same tag
Hero(
  tag: 'unique_hero_tag', // Same tag!
  child: Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,
    ),
    child: Icon(Icons.star, size: 100),
  ),
)
```

**When to use:**
- Image galleries
- Card-to-detail transitions
- Shared element transitions
- Creating visual continuity between screens

**File:** `lib/examples/hero_animations_example.dart`

---

### 4. Physics Animations

**What they are:** Physics animations simulate real-world physics like gravity, springs, and friction. They create natural, realistic motion that feels organic.

**Key Components:**
- `SpringSimulation` - Spring physics (bouncing, elastic motion)
- `GravitySimulation` - Gravity effects
- `FrictionSimulation` - Friction and damping

**How they work:**
```dart
// Spring Animation
final spring = SpringDescription(
  mass: 1,
  stiffness: 100,
  damping: 10,
);

final simulation = SpringSimulation(spring, 0, 1, 0);
_controller.animateWith(simulation);

// Gravity Animation
final gravity = GravitySimulation(
  500.0,  // acceleration
  0.0,    // starting position
  400.0,  // ending position
  0.0,    // starting velocity
);
_controller.animateWith(gravity);
```

**When to use:**
- Realistic motion effects
- Bouncing elements
- Draggable widgets with physics
- Natural-feeling interactions

**File:** `lib/examples/physics_animations_example.dart`

---

### 5. Staggered Animations

**What they are:** Staggered animations sequence multiple animations with delays, creating a cascading or wave effect. Items appear one after another rather than simultaneously.

**How they work:**
```dart
// Create multiple controllers
final controllers = List.generate(
  5,
  (index) => AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  ),
);

// Start animations with delays
void _startStaggeredAnimation() {
  for (int i = 0; i < controllers.length; i++) {
    Future.delayed(
      Duration(milliseconds: i * 100), // Delay increases
      () => controllers[i].forward(),
    );
  }
}

// Use SlideTransition for each item
SlideTransition(
  position: _slideAnimations[index],
  child: FadeTransition(
    opacity: _fadeAnimations[index],
    child: YourWidget(),
  ),
)
```

**When to use:**
- List item animations
- Card stacks
- Loading sequences
- Wave effects
- Sequential reveals

**File:** `lib/examples/staggered_animations_example.dart`

---

### 6. Transform Animations

**What they are:** Transform animations manipulate widgets using matrix transformations. They enable rotation, scaling, skewing, and 3D perspective effects.

**Key Transforms:**
- `Transform.rotate` - Rotation around a point
- `Transform.scale` - Scaling (size changes)
- `Transform.translate` - Position changes
- `Transform` with `Matrix4` - Advanced 3D transformations

**How they work:**
```dart
// Rotation
Transform.rotate(
  angle: _rotationAnimation.value * 2 * 3.14159,
  child: YourWidget(),
)

// Scale
Transform.scale(
  scale: _scaleAnimation.value,
  child: YourWidget(),
)

// Combined transforms
Transform.rotate(
  angle: _rotation.value * 2 * 3.14159,
  child: Transform.scale(
    scale: _scale.value,
    child: YourWidget(),
  ),
)

// 3D Perspective
Transform(
  transform: Matrix4.identity()
    ..setEntry(3, 2, 0.001)  // Perspective
    ..rotateY(_animation.value * 2 * 3.14159)
    ..rotateX(0.5),
  alignment: Alignment.center,
  child: YourWidget(),
)
```

**When to use:**
- Spinning loaders
- Card flips
- 3D effects
- Zoom interactions
- Perspective views

**File:** `lib/examples/transform_animations_example.dart`

---

## 🏗️ Project Structure

```
lib/
├── main.dart                    # App entry point
├── screens/
│   └── home_screen.dart        # Main navigation screen
└── examples/
    ├── implicit_animations_example.dart
    ├── explicit_animations_example.dart
    ├── hero_animations_example.dart
    ├── physics_animations_example.dart
    ├── staggered_animations_example.dart
    └── transform_animations_example.dart
```

## 💡 Animation Best Practices

### 1. Performance
- Use `const` constructors where possible
- Avoid rebuilding entire widget trees during animations
- Use `RepaintBoundary` for complex animated widgets
- Prefer implicit animations for simple cases

### 2. User Experience
- Keep animations under 500ms for most interactions
- Use appropriate curves (easeInOut, bounce, elastic)
- Provide visual feedback for all interactions
- Don't overuse animations - they should enhance, not distract

### 3. Code Organization
- Extract complex animations into separate widgets
- Use `TickerProviderStateMixin` for multiple controllers
- Dispose controllers properly to prevent memory leaks
- Document animation parameters and purposes

### 4. Common Patterns

**Single Animation Controller:**
```dart
class _MyWidgetState extends State<MyWidget> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // ...
}
```

**Multiple Animation Controllers:**
```dart
class _MyWidgetState extends State<MyWidget> 
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  // ...
}
```

**Dispose Pattern:**
```dart
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

## 🎓 Learning Resources

- [Flutter Animation Documentation](https://docs.flutter.dev/development/ui/animations)
- [Animation Tutorial](https://docs.flutter.dev/development/ui/animations/tutorial)
- [Implicit vs Explicit Animations](https://docs.flutter.dev/development/ui/animations/implicit-animations)
- [Hero Animations Guide](https://docs.flutter.dev/development/ui/animations/hero-animations)

## 🔧 Troubleshooting

### Common Issues

1. **Animation not working:**
   - Ensure `vsync` is provided to AnimationController
   - Check that `setState()` is called when changing animation values
   - Verify animation controller is properly initialized

2. **Performance issues:**
   - Use `RepaintBoundary` to isolate repaints
   - Avoid animating expensive operations
   - Consider using `AnimatedBuilder` instead of rebuilding entire tree

3. **Memory leaks:**
   - Always dispose AnimationControllers
   - Remove listeners when widgets are disposed
   - Use `TickerProviderStateMixin` correctly

## 📝 Code Examples Summary

### Quick Reference

**Implicit Animation:**
```dart
AnimatedContainer(duration: Duration(seconds: 1), ...)
```

**Explicit Animation:**
```dart
AnimationController + Tween + AnimatedBuilder
```

**Hero Animation:**
```dart
Hero(tag: 'tag', child: Widget())
```

**Physics Animation:**
```dart
SpringSimulation + controller.animateWith()
```

**Staggered Animation:**
```dart
Multiple controllers + Future.delayed()
```

**Transform Animation:**
```dart
Transform.rotate/scale/translate or Matrix4
```

## 🚀 Next Steps

1. Experiment with different animation curves
2. Combine multiple animation types
3. Create custom animation widgets
4. Add gesture-based animations
5. Implement page transition animations

## 📄 License

This project is open source and available for learning purposes.

## 🤝 Contributing

Feel free to fork this project and add your own animation examples!

---

**Happy Animating! 🎉**
