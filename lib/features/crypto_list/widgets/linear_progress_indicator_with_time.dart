import 'package:flutter/material.dart';

class LinearProgressIndicatorWithTime extends StatefulWidget {
  const LinearProgressIndicatorWithTime({super.key, required this.duration});

  final Duration duration;

  @override
  State<LinearProgressIndicatorWithTime> createState() => _LinearProgressIndicatorWithTimeState();
}

class _LinearProgressIndicatorWithTimeState extends State<LinearProgressIndicatorWithTime> 
    with TickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _controller.forward();
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
        return LinearProgressIndicator(
          value: _animation.value,
        );
      }
    );
  }
}