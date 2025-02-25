import 'package:flutter/material.dart';
import '/src/config/config.dart';

class CustomCard extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final Color? color;
  final BoxShape shape;
  final BorderRadius borderRadius;
  final Gradient? gradient;

  const CustomCard({
    super.key,
    this.width,
    this.height,
    required this.child,
    this.padding = const EdgeInsets.all(8.0),
    this.margin,
    this.color = ColorManager.lightBackgroundColor,
    this.shape = BoxShape.rectangle,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: color, borderRadius: shape == BoxShape.circle ? null : borderRadius, shape: shape, gradient: gradient),
      child: child,
    );
  }
}

class CustomDoubleCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color? color;

  const CustomDoubleCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(4.0),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: ColorManager.primaryColor.withValues(alpha: 0.08),
      padding: EdgeInsets.all(8.0),
      child: CustomCard(
        color: color ?? ColorManager.primaryColor.withValues(alpha: 0.08),
        padding: padding,
        child: child,
      ),
    );
  }
}
