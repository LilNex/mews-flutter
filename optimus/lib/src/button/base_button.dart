import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/constants.dart';
import 'package:optimus/src/typography/presets.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.color,
    this.minWidth,
    this.leftIcon,
    this.rightIcon,
    this.badgeLabel,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusButtonVariant.defaultButton,
    this.borderRadius = const BorderRadius.all(borderRadius50),
  }) : super(key: key);

  final VoidCallback? onPressed;

  final Widget child;

  final Color? color;

  final double? minWidth;

  final IconData? leftIcon;

  final IconData? rightIcon;

  final String? badgeLabel;

  final OptimusWidgetSize size;

  final OptimusButtonVariant variant;

  final BorderRadius borderRadius;

  Widget _buildIcon(IconData icon, OptimusThemeData theme) =>
      Icon(icon, size: _iconSize, color: _textColor(theme));

  TextStyle get _textStyle =>
      size == OptimusWidgetSize.small ? preset200b : preset300b;

  Widget _buildBadgeLabel(String badgeLabel, OptimusThemeData theme) =>
      SizedBox(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Container(
            height: 16,
            color: _textColor(theme),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacing50),
              child: Text(
                badgeLabel,
                style: preset100s.copyWith(
                  color: _badgeTextColor(theme),
                  height: 1.3,
                ),
              ),
            ),
          ),
        ),
      );

  double get _iconSize {
    switch (size) {
      case OptimusWidgetSize.small:
        return 16;
      case OptimusWidgetSize.medium:
      case OptimusWidgetSize.large:
        return 24;
    }
  }

  Color _color(OptimusThemeData theme) {
    if (color != null) {
      return color!.withAlpha(255);
      
    } else {
      switch (variant) {
      case OptimusButtonVariant.defaultButton:
        return theme.colors.neutral50;
      case OptimusButtonVariant.primary:
        return theme.colors.primary500;
      case OptimusButtonVariant.text:
        return Colors.transparent;
      case OptimusButtonVariant.destructive:
        return theme.colors.danger500;
      case OptimusButtonVariant.warning:
        return theme.colors.warning500;
      default:
        return theme.colors.primary500;
    }
    }
  }

  Color _badgeTextColor(OptimusThemeData theme) {
    switch (variant) {
      case OptimusButtonVariant.defaultButton:
        return theme.colors.neutral0;
      case OptimusButtonVariant.primary:
        return theme.colors.primary500;
      case OptimusButtonVariant.text:
        return theme.isDark ? theme.colors.neutral1000 : theme.colors.neutral0;
      case OptimusButtonVariant.destructive:
        return theme.colors.danger500;
      case OptimusButtonVariant.warning:
        return theme.colors.warning500;
    }
  }

  Color _hoverColor(OptimusThemeData theme) {
    if (color != null) {
      return color!.withAlpha(200);
    } else {
      switch (variant) {
      case OptimusButtonVariant.defaultButton:
        return theme.colors.neutral100;
      case OptimusButtonVariant.primary:
        return theme.colors.primary700;
      case OptimusButtonVariant.text:
        return theme.colors.neutral500t8;
      case OptimusButtonVariant.destructive:
        return theme.colors.danger700;
      case OptimusButtonVariant.warning:
        return theme.colors.warning700;
      default:
        return theme.colors.primary700;
    }
    }

    
  }

  Color _highLightColor(OptimusThemeData theme) {

    if (color != null) {
      return color!.withAlpha(150);
    } else {
      switch (variant) {
      case OptimusButtonVariant.defaultButton:
        return theme.colors.neutral100;
      case OptimusButtonVariant.primary:
        return theme.colors.primary700;
      case OptimusButtonVariant.text:
        return theme.colors.neutral500t8;
      case OptimusButtonVariant.destructive:
        return theme.colors.danger700;
      case OptimusButtonVariant.warning:
        return theme.colors.warning700;
      default:
        return theme.colors.primary700;
    }
    }
  }

  Color _textColor(OptimusThemeData theme) {
    switch (variant) {
      case OptimusButtonVariant.defaultButton:
        return theme.colors.neutral500;
      case OptimusButtonVariant.primary:
        return theme.colors.neutral0;
      case OptimusButtonVariant.text:
        // TODO(V): can be changed when final dark theme design is ready.
        return theme.isDark ? theme.colors.neutral0 : theme.colors.neutral500;
      case OptimusButtonVariant.destructive:
        return theme.colors.neutral0;
      case OptimusButtonVariant.warning:
        return theme.colors.neutral900;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Opacity(
      opacity: onPressed != null ? OpacityValue.enabled : OpacityValue.disabled,
      child: MaterialButton(
        minWidth: minWidth,
        height: size.value,
        visualDensity: VisualDensity.standard,
        elevation: 0,
        highlightElevation: 0,
        highlightColor: _highLightColor(theme),
        disabledColor: _color(theme),
        disabledTextColor: _textColor(theme),
        hoverElevation: 0,
        splashColor: Colors.transparent,
        hoverColor: _hoverColor(theme),
        onPressed: onPressed,
        animationDuration: buttonAnimationDuration,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        color: _color(theme),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (leftIcon != null) _buildIcon(leftIcon!, theme),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacing100),
              child: DefaultTextStyle.merge(
                child: child,
                style: _textStyle.copyWith(
                  color: _textColor(theme),
                  height: 1,
                ),
              ),
            ),
            if (rightIcon != null) _buildIcon(rightIcon!, theme),
            if (badgeLabel != null && badgeLabel!.isNotEmpty)
              _buildBadgeLabel(badgeLabel!, theme),
          ],
        ),
      ),
    );
  }
}
