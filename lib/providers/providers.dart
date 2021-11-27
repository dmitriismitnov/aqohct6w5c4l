import 'dart:async';
import 'dart:math' as math;

import 'package:aqohct6w5c4l/models/models.dart';

part 'products_provider.dart';

Future<void> _networkDelay() {
  return Future<void>.delayed(const Duration(seconds: 2));
}
