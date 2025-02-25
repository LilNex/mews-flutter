import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/field_error.dart';
import 'package:optimus/src/common/field_label.dart';
import 'package:optimus/src/constants.dart';
import 'package:optimus/src/typography/presets.dart';

class FieldWrapper extends StatefulWidget {
  const FieldWrapper({
    Key? key,
    this.isEnabled = true,
    required this.focusNode,
    this.label,
    this.caption,
    this.secondaryCaption,
    this.error,
    this.hasBorders = true,
    this.isRequired = false,
    this.suffix,
    this.prefix,
    this.fieldBoxKey,
    this.children = const <Widget>[],
  }) : super(key: key);

  final bool isEnabled;
  final FocusNode focusNode;
  final String? label;
  final Widget? caption;
  final Widget? secondaryCaption;
  final String? error;
  final bool hasBorders;
  final bool isRequired;
  final Widget? suffix;
  final Widget? prefix;
  final List<Widget> children;
  final Key? fieldBoxKey;

  bool get hasError => error != null && error!.isNotEmpty;

  @override
  _FieldWrapper createState() => _FieldWrapper();
}

class _FieldWrapper extends State<FieldWrapper> with ThemeGetter {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: [
              if (widget.label != null)
                OptimusFieldLabel(
                  label: widget.label!,
                  isRequired: widget.isRequired,
                ),
              const Spacer(),
              if (widget.secondaryCaption != null)
                OptimusCaption(
                  variation: Variation.variationSecondary,
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      color: _secondaryCaptionColor,
                    ),
                    child: widget.secondaryCaption!,
                  ),
                ),
            ],
          ),
          Opacity(
            opacity:
                widget.isEnabled ? OpacityValue.enabled : OpacityValue.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IgnorePointer(
                  ignoring: !widget.isEnabled,
                  child: _FieldPadding(
                    // Decoration is nullable, cannot use DecoratedBox
                    // ignore: use_decorated_box
                    child: Container(
                      key: widget.fieldBoxKey,
                      decoration: widget.hasBorders
                          ? BoxDecoration(
                              color: _background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              border: Border.all(color: _borderColor, width: 1),
                            )
                          : null,
                      child: Row(
                        children: _buildChildren(),
                      ),
                    ),
                  ),
                ),
                if (widget.hasError) OptimusFieldError(error: widget.error!),
                if (!widget.hasError && widget.caption != null)
                  OptimusCaption(
                    child: DefaultTextStyle.merge(
                      style: TextStyle(color: _captionColor),
                      child: widget.caption!,
                    ),
                  ),
              ],
            ),
          ),
        ],
      );

  void _onFocusChanged() {
    setState(() {});
  }

  Color get _background =>
      theme.isDark ? theme.colors.neutral500 : theme.colors.neutral0;

  Color get _secondaryCaptionColor =>
      theme.isDark ? theme.colors.neutral0t32 : theme.colors.neutral1000t32;

  Color get _borderColor {
    if (widget.hasError) return theme.colors.danger;

    return widget.focusNode.hasFocus
        ? theme.colors.primary
        : theme.colors.neutral100;
  }

  Color get _captionColor => widget.focusNode.hasFocus
      ? theme.colors.primary
      : theme.isDark
          ? theme.colors.neutral0t64
          : theme.colors.neutral1000t64;

  List<Widget> _buildChildren() => <Widget>[
        if (widget.prefix != null)
          _Icon(child: _PrefixPadding(child: widget.prefix!)),
        ...widget.children,
        if (widget.suffix != null)
          DefaultTextStyle.merge(
            style: preset100b.copyWith(color: theme.colors.neutral1000t32),
            child: _Icon(child: _SuffixPadding(child: widget.suffix!)),
          )
      ];
}

class _Icon extends StatelessWidget {
  const _Icon({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => IconTheme(
        data: IconThemeData(color: _iconColor(context), size: 24),
        child: child,
      );

  Color _iconColor(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000t64;
  }
}

class _FieldPadding extends StatelessWidget {
  const _FieldPadding({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: spacing25),
        child: child,
      );
}

class _SuffixPadding extends StatelessWidget {
  const _SuffixPadding({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 10),
        child: child,
      );
}

class _PrefixPadding extends StatelessWidget {
  const _PrefixPadding({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 10),
        child: child,
      );
}
