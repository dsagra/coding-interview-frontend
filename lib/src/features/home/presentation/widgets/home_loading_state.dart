import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import 'money_loader.dart';

class HomeLoadingState extends StatelessWidget {
  const HomeLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(color: AppColors.background, child: MoneyLoader());
  }
}
