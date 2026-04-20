import 'package:flutter/material.dart';
import 'package:coding_interview_frontend/l10n/generated/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'primary_action_button.dart';

class ConfirmChangeDialog extends StatelessWidget {
  const ConfirmChangeDialog({
    super.key,
    required this.isSell,
    required this.fromCurrencyCode,
    required this.toCurrencyCode,
    required this.amount,
    required this.estimatedReceive,
    required this.estimatedRate,
    required this.estimatedTime,
    required this.quoteReady,
    required this.onConfirm,
  });

  final bool isSell;
  final String fromCurrencyCode;
  final String toCurrencyCode;
  final double amount;
  final double estimatedReceive;
  final double estimatedRate;
  final String estimatedTime;
  final bool quoteReady;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Dialog(
      backgroundColor: AppColors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.dialogGradientStart,
              AppColors.dialogGradientEnd,
            ],
          ),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.white12),
          boxShadow: const [
            BoxShadow(
              color: AppColors.black38,
              blurRadius: 30,
              offset: Offset(0, 16),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.swap_horiz_rounded,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    l10n.operationSummaryTitle,
                    style: AppTextStyles.dialogTitle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              isSell ? l10n.sellingLabel : l10n.buyingLabel,
              style: AppTextStyles.dialogActionType,
            ),
            const SizedBox(height: 14),
            _SwapSummaryCard(
              actionLabel: isSell ? l10n.sellingLabel : l10n.buyingLabel,
              amountLabel: '${amount.toStringAsFixed(2)} $fromCurrencyCode',
              receiveLabel:
                  '${estimatedReceive.toStringAsFixed(2)} $toCurrencyCode',
              rateLabel:
                  '1 $fromCurrencyCode = ${estimatedRate.toStringAsFixed(4)} $toCurrencyCode',
              timeLabel: '${l10n.estimatedTimeLabel}: $estimatedTime',
              quoteReady: quoteReady,
            ),
            const SizedBox(height: 18),
            Text(
              l10n.summaryDescription,
              style: AppTextStyles.dialogDescription,
            ),
            const SizedBox(height: 16),
            PrimaryActionButton(
              text: l10n.summaryCloseAndResetButton,
              onPressed: onConfirm,
            ),
          ],
        ),
      ),
    );
  }
}

class _SwapSummaryCard extends StatelessWidget {
  const _SwapSummaryCard({
    required this.actionLabel,
    required this.amountLabel,
    required this.receiveLabel,
    required this.rateLabel,
    required this.timeLabel,
    required this.quoteReady,
  });

  final String actionLabel;
  final String amountLabel;
  final String receiveLabel;
  final String rateLabel;
  final String timeLabel;
  final bool quoteReady;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white05,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SummaryLine(label: actionLabel, value: amountLabel, emphasize: true),
          const SizedBox(height: 14),
          _SummaryLine(label: l10n.summaryReceiveLabel, value: receiveLabel),
          const SizedBox(height: 10),
          _SummaryLine(label: l10n.summaryRateLabel, value: rateLabel),
          const SizedBox(height: 10),
          _SummaryLine(
            label: l10n.summaryStatusLabel,
            value: quoteReady
                ? l10n.summaryQuoteReady
                : l10n.summaryQuoteMissing,
          ),
          const SizedBox(height: 10),
          _SummaryLine(label: l10n.summaryTimeLabel, value: timeLabel),
        ],
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.summaryLabel(emphasize: emphasize),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTextStyles.summaryValue(emphasize: emphasize),
          ),
        ),
      ],
    );
  }
}
