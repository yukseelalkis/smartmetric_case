import 'package:flutter/material.dart';

/// [DeviceSizeExtension] is an extension on [BuildContext] to get device size properties.
extension DeviceSizeContextExtension on BuildContext {
  /// Width of the device
  double get deviceWidth => MediaQuery.sizeOf(this).width;

  /// Height of the device
  double get deviceHeight => MediaQuery.sizeOf(this).height;

  /// Aspect ratio of the device
  double get deviceAspectRatio => MediaQuery.sizeOf(this).aspectRatio;
}
