import 'package:flutter/material.dart';
import 'package:coding_interview_frontend/l10n/generated/app_localizations.dart';
import '../../../../core/constants/app_text_styles.dart';

class MoneyLoader extends StatefulWidget {
  const MoneyLoader({super.key});

  @override
  State<MoneyLoader> createState() => _MoneyLoaderState();
}

class _MoneyLoaderState extends State<MoneyLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotateAnimation.value,
                  child: Text('\$', style: AppTextStyles.moneyLoaderSymbol),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(l10n.loadingLabel, style: AppTextStyles.moneyLoaderLabel),
        ],
      ),
    );
  }
}
