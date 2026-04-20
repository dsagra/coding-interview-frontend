import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'primary_action_button.dart';
import 'language_selector_button.dart';

class HomeContentLayout extends StatelessWidget {
  const HomeContentLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.background),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final accentSize = constraints.maxHeight * 1.2;

          return Stack(
            children: [
              Positioned(
                right: -(accentSize * 0.82),
                top: -(accentSize * 0.18),
                child: _CircleAccent(size: accentSize),
              ),
              const Positioned(
                top: 12,
                right: 12,
                child: SafeArea(child: LanguageSelectorButton()),
              ),
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 28,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HomeUnavailableState extends StatelessWidget {
  const HomeUnavailableState({
    super.key,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return HomeContentLayout(
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 30,
              offset: Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.cloud_off_rounded,
                color: AppColors.text,
                size: 34,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.homeUnavailableTitle,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: AppTextStyles.homeUnavailableDescription,
            ),
            const SizedBox(height: 22),
            PrimaryActionButton(text: actionLabel, onPressed: onAction),
          ],
        ),
      ),
    );
  }
}

class _CircleAccent extends StatelessWidget {
  const _CircleAccent({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
    );
  }
}
