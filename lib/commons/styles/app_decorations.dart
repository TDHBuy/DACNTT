import 'package:booking/commons/styles/app_colors.dart';
import 'package:booking/commons/styles/app_spacing.dart';
import 'package:booking/commons/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppDecorations {
  // ============================================
  // CARD DECORATIONS
  // ============================================
  static BoxDecoration card = BoxDecoration(
    color: TAppColors.surface,
    borderRadius: BorderRadius.circular(TAppSpacing.cardBorderRadius),
    boxShadow: TAppColors.shadowSM,
    border: Border.all(
      color: TAppColors.border,
      width: 1,
    ),
  );

  static BoxDecoration cardHover = BoxDecoration(
    color: TAppColors.surface,
    borderRadius: BorderRadius.circular(TAppSpacing.cardBorderRadius),
    boxShadow: TAppColors.shadowMD,
    border: Border.all(
      color: TAppColors.primary.withOpacity(0.3),
      width: 1,
    ),
  );

  static BoxDecoration cardElevated = BoxDecoration(
    color: TAppColors.surface,
    borderRadius: BorderRadius.circular(TAppSpacing.cardBorderRadius),
    boxShadow: TAppColors.shadowLG,
  );

  static BoxDecoration cardOutlined = BoxDecoration(
    color: TAppColors.surface,
    borderRadius: BorderRadius.circular(TAppSpacing.cardBorderRadius),
    border: Border.all(
      color: TAppColors.border,
      width: 1.5,
    ),
  );

  static BoxDecoration cardPrimary = BoxDecoration(
    gradient: TAppColors.primaryGradient,
    borderRadius: BorderRadius.circular(TAppSpacing.cardBorderRadius),
    boxShadow: TAppColors.shadowMD,
  );

  // ============================================
  // INPUT DECORATIONS
  // ============================================
  static InputDecoration input({
    String? label,
    String? hint,
    IconData? prefixIcon,
    Widget? suffixIcon,
    String? errorText,
    bool enabled = true,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      errorText: errorText,
      enabled: enabled,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: TAppSpacing.iconSizeMedium) : null,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: enabled ? TAppColors.surface : TAppColors.backgroundDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(TAppSpacing.inputBorderRadius),
        borderSide: BorderSide(color: TAppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(TAppSpacing.inputBorderRadius),
        borderSide: BorderSide(color: TAppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(TAppSpacing.inputBorderRadius),
        borderSide: BorderSide(color: TAppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(TAppSpacing.inputBorderRadius),
        borderSide: BorderSide(color: TAppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(TAppSpacing.inputBorderRadius),
        borderSide: BorderSide(color: TAppColors.error, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(TAppSpacing.inputBorderRadius),
        borderSide: BorderSide(color: TAppColors.divider),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: TAppSpacing.md,
        vertical: TAppSpacing.sm,
      ),
    );
  }

  static InputDecoration searchInput({
    String? hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint ?? 'Tìm kiếm...',
      prefixIcon: Icon(Icons.search, size: TAppSpacing.iconSizeMedium),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: TAppColors.backgroundDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(TAppSpacing.inputBorderRadius),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(TAppSpacing.inputBorderRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(TAppSpacing.inputBorderRadius),
        borderSide: BorderSide(color: TAppColors.primary, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: TAppSpacing.md,
        vertical: TAppSpacing.sm,
      ),
    );
  }

  // ============================================
  // BUTTON STYLES
  // ============================================
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: TAppColors.primary,
    foregroundColor: TAppColors.textOnPrimary,
    padding: EdgeInsets.symmetric(
      horizontal: TAppSpacing.lg,
      vertical: TAppSpacing.sm,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TAppSpacing.buttonBorderRadius),
    ),
    elevation: 2,
    shadowColor: TAppColors.primary.withOpacity(0.3),
    minimumSize: Size(0, TAppSpacing.buttonHeight),
  );

  static ButtonStyle secondaryButton = OutlinedButton.styleFrom(
    foregroundColor: TAppColors.primary,
    padding: EdgeInsets.symmetric(
      horizontal: TAppSpacing.lg,
      vertical: TAppSpacing.sm,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TAppSpacing.buttonBorderRadius),
    ),
    side: BorderSide(color: TAppColors.primary, width: 1.5),
    minimumSize: Size(0, TAppSpacing.buttonHeight),
  );

  static ButtonStyle textButton = TextButton.styleFrom(
    foregroundColor: TAppColors.primary,
    padding: EdgeInsets.symmetric(
      horizontal: TAppSpacing.md,
      vertical: TAppSpacing.sm,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TAppSpacing.buttonBorderRadius),
    ),
    minimumSize: Size(0, TAppSpacing.buttonHeight),
  );

  static ButtonStyle dangerButton = ElevatedButton.styleFrom(
    backgroundColor: TAppColors.error,
    foregroundColor: TAppColors.textOnPrimary,
    padding: EdgeInsets.symmetric(
      horizontal: TAppSpacing.lg,
      vertical: TAppSpacing.sm,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TAppSpacing.buttonBorderRadius),
    ),
    elevation: 2,
    shadowColor: TAppColors.error.withOpacity(0.3),
    minimumSize: Size(0, TAppSpacing.buttonHeight),
  );

  static ButtonStyle successButton = ElevatedButton.styleFrom(
    backgroundColor: TAppColors.success,
    foregroundColor: TAppColors.textOnPrimary,
    padding: EdgeInsets.symmetric(
      horizontal: TAppSpacing.lg,
      vertical: TAppSpacing.sm,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TAppSpacing.buttonBorderRadius),
    ),
    elevation: 2,
    shadowColor: TAppColors.success.withOpacity(0.3),
    minimumSize: Size(0, TAppSpacing.buttonHeight),
  );

  // ============================================
  // CONTAINER DECORATIONS
  // ============================================
  static BoxDecoration container = BoxDecoration(
    color: TAppColors.surface,
    borderRadius: BorderRadius.circular(TAppSpacing.cardBorderRadius),
  );

  static BoxDecoration containerWithBorder = BoxDecoration(
    color: TAppColors.surface,
    borderRadius: BorderRadius.circular(TAppSpacing.cardBorderRadius),
    border: Border.all(color: TAppColors.border),
  );

  static BoxDecoration containerWithShadow = BoxDecoration(
    color: TAppColors.surface,
    borderRadius: BorderRadius.circular(TAppSpacing.cardBorderRadius),
    boxShadow: TAppColors.shadowSM,
  );

  // ============================================
  // DIVIDERS
  // ============================================
  static Divider divider = Divider(
    color: TAppColors.divider,
    thickness: 1,
    height: 1,
  );

  static Divider dividerThick = Divider(
    color: TAppColors.divider,
    thickness: 2,
    height: 2,
  );

  static VerticalDivider verticalDivider = VerticalDivider(
    color: TAppColors.divider,
    thickness: 1,
    width: 1,
  );
}
