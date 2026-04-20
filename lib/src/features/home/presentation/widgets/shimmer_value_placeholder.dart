import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ShimmerValuePlaceholder extends StatefulWidget {
  const ShimmerValuePlaceholder({super.key, this.width = 60, this.height = 20});

  final double width;
  final double height;

  @override
  State<ShimmerValuePlaceholder> createState() =>
      _ShimmerValuePlaceholderState();
}

class _ShimmerValuePlaceholderState extends State<ShimmerValuePlaceholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final position = _controller.value;
          return ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment(-1.0 + (2.0 * position), 0),
                end: Alignment(1.0 + (2.0 * position), 0),
                colors: const [
                  AppColors.shimmerBase,
                  AppColors.shimmerHighlight,
                  AppColors.shimmerBase,
                ],
                stops: const [0.25, 0.5, 0.75],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.shimmerBase,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }
}
