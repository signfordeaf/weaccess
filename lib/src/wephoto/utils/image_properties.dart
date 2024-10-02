import 'package:flutter/material.dart';

class WePhotoImageProperties {
  Key? key;
  Widget Function(BuildContext, Widget, int?, bool)? frameBuilder;
  Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder;
  Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  String? semanticLabel;
  bool? excludeFromSemantics;
  double? width;
  double? height;
  Color? color;
  Animation<double>? opacity;
  BlendMode? colorBlendMode;
  BoxFit? fit;
  AlignmentGeometry? alignment;
  ImageRepeat? repeat;
  Rect? centerSlice;
  bool? matchTextDirection;
  bool? gaplessPlayback;
  bool? isAntiAlias;
  FilterQuality? filterQuality;

  WePhotoImageProperties({
    this.key,
    this.frameBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.isAntiAlias = false,
    this.filterQuality = FilterQuality.medium,
  });
}
