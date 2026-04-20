import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: AppColors.buttonStrongShadow,
            blurRadius: 6,
            spreadRadius: 0.1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.35),
            disabledForegroundColor: AppColors.white.withValues(alpha: 0.7),
            elevation: 0,
            shadowColor: AppColors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onPressed: onPressed,
          child: Text(text, style: AppTextStyles.primaryActionButton),
        ),
      ),
    );
  }
}
