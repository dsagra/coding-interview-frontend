import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/amount_text_sanitizer.dart';

class AmountField extends StatelessWidget {
  const AmountField({
    super.key,
    required this.code,
    required this.controller,
    required this.onChanged,
  });

  final String code;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryBorder, width: 1.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(code, style: AppTextStyles.amountCode),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              keyboardType: TextInputType.number,
              inputFormatters: const [_AmountInputFormatter()],
              textAlign: TextAlign.left,
              style: AppTextStyles.amountInput,
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: '0.0',
                hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountInputFormatter extends TextInputFormatter {
  const _AmountInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final sanitized = sanitizeAmountText(newValue.text);

    if (sanitized.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
        composing: TextRange.empty,
      );
    }

    return TextEditingValue(
      text: sanitized,
      selection: TextSelection.collapsed(offset: sanitized.length),
      composing: TextRange.empty,
    );
  }
}
