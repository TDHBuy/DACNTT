import 'package:flutter/material.dart' show EdgeInsets;

class TAppSpacing {
  // ============================================
  // DESKTOP SPACING (Base - Primary)
  // ============================================
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 24.0;
  static const double lg = 32.0;
  static const double xl = 48.0;
  static const double xxl = 64.0;

  // ============================================
  // TABLET SPACING (Scale down 75%)
  // ============================================
  static const double xsTablet = 6.0;
  static const double smTablet = 10.0;
  static const double mdTablet = 20.0;
  static const double lgTablet = 28.0;
  static const double xlTablet = 36.0;
  static const double xxlTablet = 56.0;

  // ============================================
  // MOBILE SPACING (Scale down 50%)
  // ============================================
  static const double xsMobile = 4.0;
  static const double smMobile = 8.0;
  static const double mdMobile = 16.0;
  static const double lgMobile = 24.0;
  static const double xlMobile = 32.0;
  static const double xxlMobile = 48.0;

  // ============================================
  // COMMON PADDINGS (Desktop - Default)
  // ============================================
  static const EdgeInsets paddingXS = EdgeInsets.all(xs);
  static const EdgeInsets paddingSM = EdgeInsets.all(sm);
  static const EdgeInsets paddingMD = EdgeInsets.all(md);
  static const EdgeInsets paddingLG = EdgeInsets.all(lg);
  static const EdgeInsets paddingXL = EdgeInsets.all(xl);
  static const EdgeInsets paddingXXL = EdgeInsets.all(xxl);

  static const EdgeInsets paddingHorizontalXS = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets paddingHorizontalSM = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets paddingHorizontalMD = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingHorizontalLG = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets paddingHorizontalXL = EdgeInsets.symmetric(horizontal: xl);
  static const EdgeInsets paddingHorizontalXXL = EdgeInsets.symmetric(horizontal: xxl);

  static const EdgeInsets paddingVerticalXS = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets paddingVerticalSM = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets paddingVerticalMD = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets paddingVerticalLG = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets paddingVerticalXL = EdgeInsets.symmetric(vertical: xl);
  static const EdgeInsets paddingVerticalXXL = EdgeInsets.symmetric(vertical: xxl);

  // ============================================
  // TABLET PADDINGS (Fallback)
  // ============================================
  static const EdgeInsets paddingXSTablet = EdgeInsets.all(xsTablet);
  static const EdgeInsets paddingSMTablet = EdgeInsets.all(smTablet);
  static const EdgeInsets paddingMDTablet = EdgeInsets.all(mdTablet);
  static const EdgeInsets paddingLGTablet = EdgeInsets.all(lgTablet);
  static const EdgeInsets paddingXLTablet = EdgeInsets.all(xlTablet);
  static const EdgeInsets paddingXXLTablet = EdgeInsets.all(xxlTablet);

  static const EdgeInsets paddingHorizontalXSTablet = EdgeInsets.symmetric(horizontal: xsTablet);
  static const EdgeInsets paddingHorizontalSMTablet = EdgeInsets.symmetric(horizontal: smTablet);
  static const EdgeInsets paddingHorizontalMDTablet = EdgeInsets.symmetric(horizontal: mdTablet);
  static const EdgeInsets paddingHorizontalLGTablet = EdgeInsets.symmetric(horizontal: lgTablet);
  static const EdgeInsets paddingHorizontalXLTablet = EdgeInsets.symmetric(horizontal: xlTablet);

  static const EdgeInsets paddingVerticalXSTablet = EdgeInsets.symmetric(vertical: xsTablet);
  static const EdgeInsets paddingVerticalSMTablet = EdgeInsets.symmetric(vertical: smTablet);
  static const EdgeInsets paddingVerticalMDTablet = EdgeInsets.symmetric(vertical: mdTablet);
  static const EdgeInsets paddingVerticalLGTablet = EdgeInsets.symmetric(vertical: lgTablet);
  static const EdgeInsets paddingVerticalXLTablet = EdgeInsets.symmetric(vertical: xlTablet);

  // ============================================
  // MOBILE PADDINGS (Fallback)
  // ============================================
  static const EdgeInsets paddingXSMobile = EdgeInsets.all(xsMobile);
  static const EdgeInsets paddingSMMobile = EdgeInsets.all(smMobile);
  static const EdgeInsets paddingMDMobile = EdgeInsets.all(mdMobile);
  static const EdgeInsets paddingLGMobile = EdgeInsets.all(lgMobile);
  static const EdgeInsets paddingXLMobile = EdgeInsets.all(xlMobile);
  static const EdgeInsets paddingXXLMobile = EdgeInsets.all(xxlMobile);

  static const EdgeInsets paddingHorizontalXSMobile = EdgeInsets.symmetric(horizontal: xsMobile);
  static const EdgeInsets paddingHorizontalSMMobile = EdgeInsets.symmetric(horizontal: smMobile);
  static const EdgeInsets paddingHorizontalMDMobile = EdgeInsets.symmetric(horizontal: mdMobile);
  static const EdgeInsets paddingHorizontalLGMobile = EdgeInsets.symmetric(horizontal: lgMobile);
  static const EdgeInsets paddingHorizontalXLMobile = EdgeInsets.symmetric(horizontal: xlMobile);

  static const EdgeInsets paddingVerticalXSMobile = EdgeInsets.symmetric(vertical: xsMobile);
  static const EdgeInsets paddingVerticalSMMobile = EdgeInsets.symmetric(vertical: smMobile);
  static const EdgeInsets paddingVerticalMDMobile = EdgeInsets.symmetric(vertical: mdMobile);
  static const EdgeInsets paddingVerticalLGMobile = EdgeInsets.symmetric(vertical: lgMobile);
  static const EdgeInsets paddingVerticalXLMobile = EdgeInsets.symmetric(vertical: xlMobile);

  // ============================================
  // COMMON GAPS (Desktop default)
  // ============================================
  static const double gapXS = xs;
  static const double gapSM = sm;
  static const double gapMD = md;
  static const double gapLG = lg;
  static const double gapXL = xl;
  static const double gapXXL = xxl;

  static const double gapXSTablet = xsTablet;
  static const double gapSMTablet = smTablet;
  static const double gapMDTablet = mdTablet;
  static const double gapLGTablet = lgTablet;
  static const double gapXLTablet = xlTablet;
  static const double gapXXLTablet = xxlTablet;

  static const double gapXSMobile = xsMobile;
  static const double gapSMMobile = smMobile;
  static const double gapMDMobile = mdMobile;
  static const double gapLGMobile = lgMobile;
  static const double gapXLMobile = xlMobile;
  static const double gapXXLMobile = xxlMobile;

  // ============================================
  // LAYOUT SPECIFIC SPACING
  // ============================================

  // Sidebar
  static const double sidebarWidth = 280.0;
  static const double sidebarWidthCollapsed = 80.0;
  static const double sidebarWidthTablet = 240.0;

  // AppBar
  static const double appBarHeight = 64.0;
  static const double appBarHeightTablet = 56.0;
  static const double appBarHeightMobile = 56.0;

  // Content
  static const double contentMaxWidth = 1440.0;
  static const double contentPadding = xl;
  static const double contentPaddingTablet = lgTablet;
  static const double contentPaddingMobile = mdMobile;

  // Cards
  static const double cardBorderRadius = 12.0;
  static const double cardBorderRadiusLarge = 16.0;
  static const double cardBorderRadiusSmall = 8.0;

  // Buttons
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 40.0;
  static const double buttonHeightLarge = 56.0;
  static const double buttonBorderRadius = 8.0;

  // Inputs
  static const double inputHeight = 48.0;
  static const double inputBorderRadius = 8.0;

  // Icons
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 20.0;
  static const double iconSizeLarge = 24.0;
  static const double iconSizeXLarge = 32.0;
}
