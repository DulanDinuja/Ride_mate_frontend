import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Animated liquid background with floating bubbles
class LiquidBackground extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  final int bubbleCount;

  const LiquidBackground({
    super.key,
    required this.child,
    this.colors,
    this.bubbleCount = 6,
  });

  @override
  State<LiquidBackground> createState() => _LiquidBackgroundState();
}

class _LiquidBackgroundState extends State<LiquidBackground>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<Offset> _positions;
  late List<double> _sizes;

  @override
  void initState() {
    super.initState();
    _controllers = [];
    _animations = [];
    _positions = [];
    _sizes = [];

    final random = Random();
    for (int i = 0; i < widget.bubbleCount; i++) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 3000 + random.nextInt(4000)),
        vsync: this,
      )..repeat(reverse: true);

      _controllers.add(controller);
      _animations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        ),
      );
      _positions.add(
        Offset(
          random.nextDouble(),
          random.nextDouble(),
        ),
      );
      _sizes.add(100.0 + random.nextDouble() * 150);
    }
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
    final size = MediaQuery.of(context).size;
    final colors = widget.colors ??
        [
          AppColors.primaryDark,
          AppColors.primary,
          AppColors.secondary,
        ];

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
        ),
      ),
      child: Stack(
        children: [
          // Animated liquid bubbles
          ...List.generate(widget.bubbleCount, (index) {
            return AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                final progress = _animations[index].value;
                final xOffset = sin(progress * 2 * pi) * 0.1;
                final yOffset = cos(progress * 2 * pi) * 0.1;

                return Positioned(
                  left: (_positions[index].dx + xOffset) * size.width -
                      _sizes[index] / 2,
                  top: (_positions[index].dy + yOffset) * size.height -
                      _sizes[index] / 2,
                  child: Container(
                    width: _sizes[index],
                    height: _sizes[index],
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.cyan.withOpacity(0.15),
                          AppColors.accent.withOpacity(0.05),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
          // Child content
          widget.child,
        ],
      ),
    );
  }
}

/// Animated gradient overlay with liquid effect
class LiquidGradientOverlay extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  final Duration duration;

  const LiquidGradientOverlay({
    super.key,
    required this.child,
    this.colors = const [
      AppColors.primaryDark,
      AppColors.primary,
      AppColors.secondary,
    ],
    this.duration = const Duration(seconds: 5),
  });

  @override
  State<LiquidGradientOverlay> createState() => _LiquidGradientOverlayState();
}

class _LiquidGradientOverlayState extends State<LiquidGradientOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.colors,
              stops: [
                0.0,
                _animation.value * 0.5,
                1.0,
              ],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

/// Shimmer effect for glass elements
class GlassShimmer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Color baseColor;
  final Color highlightColor;

  const GlassShimmer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.baseColor = AppColors.surface,
    this.highlightColor = AppColors.cyan,
  });

  @override
  State<GlassShimmer> createState() => _GlassShimmerState();
}

class _GlassShimmerState extends State<GlassShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.baseColor.withOpacity(0.3),
                widget.highlightColor.withOpacity(0.2),
                widget.baseColor.withOpacity(0.3),
              ],
              stops: [
                0.0,
                _animation.value / 2 + 0.5,
                1.0,
              ],
              tileMode: TileMode.clamp,
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}

/// Floating particles effect
class FloatingParticles extends StatefulWidget {
  final int particleCount;
  final Color particleColor;

  const FloatingParticles({
    super.key,
    this.particleCount = 20,
    this.particleColor = AppColors.cyan,
  });

  @override
  State<FloatingParticles> createState() => _FloatingParticlesState();
}

class _FloatingParticlesState extends State<FloatingParticles>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<Offset> _positions;
  late List<double> _sizes;

  @override
  void initState() {
    super.initState();
    _controllers = [];
    _animations = [];
    _positions = [];
    _sizes = [];

    final random = Random();
    for (int i = 0; i < widget.particleCount; i++) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 2000 + random.nextInt(3000)),
        vsync: this,
      )..repeat();

      _controllers.add(controller);
      _animations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(controller),
      );
      _positions.add(
        Offset(
          random.nextDouble(),
          random.nextDouble(),
        ),
      );
      _sizes.add(2.0 + random.nextDouble() * 4);
    }
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
    final size = MediaQuery.of(context).size;

    return Stack(
      children: List.generate(widget.particleCount, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            final progress = _animations[index].value;
            final yPos = (_positions[index].dy - progress) % 1.0;

            return Positioned(
              left: _positions[index].dx * size.width,
              top: yPos * size.height,
              child: Container(
                width: _sizes[index],
                height: _sizes[index],
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.particleColor.withOpacity(0.6),
                  boxShadow: [
                    BoxShadow(
                      color: widget.particleColor.withOpacity(0.4),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
