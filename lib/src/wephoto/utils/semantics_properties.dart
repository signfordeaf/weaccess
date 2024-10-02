import 'package:flutter/semantics.dart';

class WeAccessSemanticsProperties {
  Key? key;
  bool? container;
  bool? explicitChildNodes;
  bool? excludeSemantics;
  bool? blockUserActions;
  bool? enabled;
  bool? checked;
  bool? mixed;
  bool? selected;
  bool? toggled;
  bool? button;
  bool? slider;
  bool? keyboardKey;
  bool? link;
  bool? header;
  int? headingLevel;
  bool? textField;
  bool? readOnly;
  bool? focusable;
  bool? focused;
  bool? inMutuallyExclusiveGroup;
  bool? obscured;
  bool? multiline;
  bool? scopesRoute;
  bool? namesRoute;
  bool? hidden;
  bool? image;
  bool? liveRegion;
  bool? expanded;
  int? maxValueLength;
  int? currentValueLength;
  String? identifier;

  /// If you enter a value here, it becomes the main label and the WePhoto image description does not work.
  ///
  /// If you don't want a WePhoto description and want to make your own image description, just enter a value here.
  String? label;
  AttributedString? attributedLabel;
  String? value;
  AttributedString? attributedValue;
  String? increasedValue;
  AttributedString? attributedIncreasedValue;
  String? decreasedValue;
  AttributedString? attributedDecreasedValue;
  String? hint;
  AttributedString? attributedHint;
  String? tooltip;
  String? onTapHint;
  String? onLongPressHint;
  TextDirection? textDirection;
  SemanticsSortKey? sortKey;
  SemanticsTag? tagForChildren;
  void Function()? onTap;
  void Function()? onLongPress;
  void Function()? onScrollLeft;
  void Function()? onScrollRight;
  void Function()? onScrollUp;
  void Function()? onScrollDown;
  void Function()? onIncrease;
  void Function()? onDecrease;
  void Function()? onCopy;
  void Function()? onCut;
  void Function()? onPaste;
  void Function()? onDismiss;
  void Function(bool)? onMoveCursorForwardByCharacter;
  void Function(bool)? onMoveCursorBackwardByCharacter;
  void Function(TextSelection)? onSetSelection;
  void Function(String)? onSetText;
  void Function()? onDidGainAccessibilityFocus;
  void Function()? onDidLoseAccessibilityFocus;
  void Function()? onFocus;
  Map<CustomSemanticsAction, void Function()>? customSemanticsActions;

  WeAccessSemanticsProperties({
    this.key,
    this.container = false,
    this.explicitChildNodes = false,
    this.excludeSemantics = true,
    this.blockUserActions = false,
    this.enabled,
    this.checked,
    this.mixed,
    this.selected,
    this.toggled,
    this.button,
    this.slider,
    this.keyboardKey,
    this.link,
    this.header,
    this.headingLevel,
    this.textField,
    this.readOnly,
    this.focusable,
    this.focused,
    this.inMutuallyExclusiveGroup,
    this.obscured,
    this.multiline,
    this.scopesRoute,
    this.namesRoute,
    this.hidden,
    this.image,
    this.liveRegion,
    this.expanded,
    this.maxValueLength,
    this.currentValueLength,
    this.identifier,
    this.label,
    this.attributedLabel,
    this.value,
    this.attributedValue,
    this.increasedValue,
    this.attributedIncreasedValue,
    this.decreasedValue,
    this.attributedDecreasedValue,
    this.hint,
    this.attributedHint,
    this.tooltip,
    this.onTapHint,
    this.onLongPressHint,
    this.textDirection,
    this.sortKey,
    this.tagForChildren,
    this.onTap,
    this.onLongPress,
    this.onScrollLeft,
    this.onScrollRight,
    this.onScrollUp,
    this.onScrollDown,
    this.onIncrease,
    this.onDecrease,
    this.onCopy,
    this.onCut,
    this.onPaste,
    this.onDismiss,
    this.onMoveCursorForwardByCharacter,
    this.onMoveCursorBackwardByCharacter,
    this.onSetSelection,
    this.onSetText,
    this.onDidGainAccessibilityFocus,
    this.onDidLoseAccessibilityFocus,
    this.onFocus,
    this.customSemanticsActions,
  });
}
