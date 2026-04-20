import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/constants/app_colors.dart';

class CurrencyImage extends StatelessWidget {
  const CurrencyImage({
    super.key,
    required this.path,
    required this.width,
    required this.height,
  });

  final String path;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return CachedNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (_, _) => _loadingPlaceholder(),
        errorWidget: (_, _, _) => _placeholder(),
      );
    }

    if (path.isNotEmpty) {
      return Image.asset(
        path,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _placeholder(),
      );
    }

    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      color: AppColors.currencyPlaceholder,
      alignment: Alignment.center,
      child: Icon(Icons.currency_exchange, size: width * 0.6),
    );
  }

  Widget _loadingPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: AppColors.currencyLoadingPlaceholder,
      alignment: Alignment.center,
      child: SizedBox(
        width: width * 0.35,
        height: width * 0.35,
        child: const CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
