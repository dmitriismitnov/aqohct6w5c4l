import 'package:flutter/material.dart' show Theme;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class PrimaryIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;

  const PrimaryIconButton({
    required this.onPressed,
    required this.child,
    Key? key,
  }) : super(key: key);

  void _onTap() {
    HapticFeedback.mediumImpact();
    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: SizedBox.square(
          dimension: 32,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
