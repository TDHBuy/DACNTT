import 'package:flutter/material.dart';

extension SizedBoxExtension on int {
  Widget get heightBox => SizedBox(height: toDouble());
  Widget get widthBox => SizedBox(width: toDouble());
}
