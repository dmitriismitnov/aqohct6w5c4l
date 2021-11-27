import 'package:flutter/material.dart' show CircularProgressIndicator, Theme;
import 'package:flutter/widgets.dart';

class LoadingIndicator extends StatelessWidget {
  final double dimension;
  final Color? backgroundColor;
  final Color? color;

  const LoadingIndicator({
    this.dimension = 50,
    this.backgroundColor,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SizedBox.square(
        dimension: dimension,
        child: CircularProgressIndicator(
          color: color ?? theme.colorScheme.onBackground,
          backgroundColor: backgroundColor ?? theme.colorScheme.background,
        ),
      ),
    );
  }
}
