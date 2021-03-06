import 'package:flutter/widgets.dart';

class FadeWidget extends StatefulWidget {
  final Widget child;
  final Curve curve;
  final Duration duration;

  const FadeWidget({
    required this.child,
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 200),
    Key? key,
  }) : super(key: key);

  @override
  _FadeWidgetState createState() => _FadeWidgetState();
}

class _FadeWidgetState extends State<FadeWidget> with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    final curved = CurvedAnimation(parent: controller, curve: widget.curve);
    opacity = curved.drive(Tween(begin: 0, end: 1));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: widget.child,
    );
  }
}
