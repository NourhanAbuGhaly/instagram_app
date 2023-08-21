import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  const LikeAnimation(
      {super.key,
      required this.child,
      required this.isAnimations,
      this.duration = const Duration(milliseconds: 15),
      this.onEnd,
      this.smallike = false});

  final Widget child;
  final bool isAnimations;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallike;

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this,
        duration: Duration(microseconds: widget.duration.inMilliseconds ~/ 2),
    );
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimations != oldWidget.isAnimations) {
      startAnimation();
    }
  }

  startAnimation() async {
    if (widget.isAnimations || widget.smallike) {
      await controller.forward();
      await controller.reverse();

      await Future.delayed(Duration(milliseconds: 200));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
