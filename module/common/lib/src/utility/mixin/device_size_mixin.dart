import 'package:flutter/material.dart';

/// [DeviceSizeMixin] is custom input decoration
mixin DeviceSizeMixin<T extends StatefulWidget> on State<T> {
  /// width of the device
  double get deviceWidth => MediaQuery.sizeOf(context).width;

  /// height of the device
  double get deviceHeight => MediaQuery.sizeOf(context).height;

  /// aspect ratio of the device
  double get deviceAspectRatio => MediaQuery.sizeOf(context).aspectRatio;
}
