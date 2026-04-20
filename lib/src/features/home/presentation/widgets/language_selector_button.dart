import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/providers/app_locale_provider.dart';

class LanguageSelectorButton extends ConsumerWidget {
  const LanguageSelectorButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale =
        ref.watch(appLocaleProvider) ?? Localizations.localeOf(context);
    final selectedLanguageCode = locale.languageCode == 'es' ? 'es' : 'en';
    final selectedDisplay = switch (selectedLanguageCode) {
      'en' => ('🇺🇸', 'EN'),
      _ => ('🇪🇸', 'ES'),
    };

    return PopupMenuButton<Locale?>(
      tooltip: 'Select language',
      position: PopupMenuPosition.under,
      initialValue: locale,
      onSelected: (selectedLocale) {
        ref.read(appLocaleProvider.notifier).setLocale(selectedLocale);
      },
      itemBuilder: (context) => [
        const PopupMenuItem<Locale?>(
          value: Locale('en'),
          child: Row(
            children: [Text('🇺🇸'), SizedBox(width: 10), Text('English')],
          ),
        ),
        const PopupMenuItem<Locale?>(
          value: Locale('es'),
          child: Row(
            children: [Text('🇪🇸'), SizedBox(width: 10), Text('Español')],
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: AppColors.primaryBorder.withValues(alpha: 0.22),
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(selectedDisplay.$1, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(selectedDisplay.$2, style: AppTextStyles.languageSelectorCode),
          ],
        ),
      ),
    );
  }
}
