import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weaccess/src/wephoto/constant/package_constant.dart';
import 'package:weaccess/src/wephoto/data/url_data_model.dart';
import 'package:weaccess/src/wephoto/service/wephoto_service.dart';
import 'package:weaccess/src/wephoto/utils/image_properties.dart';
import 'package:weaccess/src/wephoto/utils/semantics_properties.dart';
import 'package:weaccess/src/wephoto/utils/wephoto_controller.dart';

class WePhoto extends StatefulWidget {
  final WePhotoController? controller;
  final String descriptionType;
  final ImageProvider<Object> image;
  final WePhotoImageProperties? imageProperties;
  final WeAccessSemanticsProperties? semanticsProperties;
  const WePhoto({
    super.key,
    this.controller,
    this.descriptionType = 'short',
    required this.image,
    this.imageProperties,
    this.semanticsProperties,
  });

  @override
  State<WePhoto> createState() => _WePhotoState();
}

class _WePhotoState extends State<WePhoto> {
  @override
  void initState() {
    super.initState();
    WePhotoService.processToImage(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: kListenableBox,
        builder: (context, Box<URLDataModel> box, child) {
          return Semantics(
            key: widget.semanticsProperties?.key,
            attributedDecreasedValue:
                widget.semanticsProperties?.attributedDecreasedValue,
            attributedHint: widget.semanticsProperties?.attributedHint,
            attributedIncreasedValue:
                widget.semanticsProperties?.attributedIncreasedValue,
            attributedLabel: widget.semanticsProperties?.attributedLabel,
            attributedValue: widget.semanticsProperties?.attributedValue,
            blockUserActions:
                widget.semanticsProperties?.blockUserActions ?? false,
            button: widget.semanticsProperties?.button,
            checked: widget.semanticsProperties?.checked,
            container: widget.semanticsProperties?.container ?? false,
            currentValueLength: widget.semanticsProperties?.currentValueLength,
            enabled: widget.semanticsProperties?.enabled,
            excludeSemantics:
                widget.semanticsProperties?.excludeSemantics ?? true,
            expanded: widget.semanticsProperties?.expanded,
            focusable: widget.semanticsProperties?.focusable,
            focused: widget.semanticsProperties?.focused,
            header: widget.semanticsProperties?.header,
            hidden: widget.semanticsProperties?.hidden,
            hint: widget.semanticsProperties?.hint,
            identifier: widget.semanticsProperties?.identifier,
            image: widget.semanticsProperties?.image,
            inMutuallyExclusiveGroup:
                widget.semanticsProperties?.inMutuallyExclusiveGroup,
            keyboardKey: widget.semanticsProperties?.keyboardKey,
            label: widget.semanticsProperties?.attributedLabel != null
                ? null
                : widget.semanticsProperties?.label ??
                    WePhotoService.getImageCaption(
                      box,
                      widget.image,
                      widget.descriptionType,
                      controller: widget.controller,
                    ),
            liveRegion: widget.semanticsProperties?.liveRegion,
            maxValueLength: widget.semanticsProperties?.maxValueLength,
            mixed: widget.semanticsProperties?.mixed,
            multiline: widget.semanticsProperties?.multiline,
            namesRoute: widget.semanticsProperties?.namesRoute,
            obscured: widget.semanticsProperties?.obscured,
            onTap: widget.semanticsProperties?.onTap,
            onTapHint: widget.semanticsProperties?.onTapHint,
            onCopy: widget.semanticsProperties?.onCopy,
            onCut: widget.semanticsProperties?.onCut,
            onDecrease: widget.semanticsProperties?.onDecrease,
            onIncrease: widget.semanticsProperties?.onIncrease,
            onLongPress: widget.semanticsProperties?.onLongPress,
            onLongPressHint: widget.semanticsProperties?.onLongPressHint,
            onPaste: widget.semanticsProperties?.onPaste,
            onScrollDown: widget.semanticsProperties?.onScrollDown,
            onScrollLeft: widget.semanticsProperties?.onScrollLeft,
            onScrollRight: widget.semanticsProperties?.onScrollRight,
            onScrollUp: widget.semanticsProperties?.onScrollUp,
            readOnly: widget.semanticsProperties?.readOnly,
            scopesRoute: widget.semanticsProperties?.scopesRoute,
            selected: widget.semanticsProperties?.selected,
            slider: widget.semanticsProperties?.slider,
            sortKey: widget.semanticsProperties?.sortKey,
            tagForChildren: widget.semanticsProperties?.tagForChildren,
            textField: widget.semanticsProperties?.textField,
            textDirection: widget.semanticsProperties?.textDirection,
            toggled: widget.semanticsProperties?.toggled,
            tooltip: widget.semanticsProperties?.tooltip,
            value: widget.semanticsProperties?.value,
            customSemanticsActions:
                widget.semanticsProperties?.customSemanticsActions,
            decreasedValue: widget.semanticsProperties?.decreasedValue,
            explicitChildNodes:
                widget.semanticsProperties?.explicitChildNodes ?? false,
            increasedValue: widget.semanticsProperties?.increasedValue,
            onDismiss: widget.semanticsProperties?.onDismiss,
            headingLevel: widget.semanticsProperties?.headingLevel,
            link: widget.semanticsProperties?.link,
            onDidGainAccessibilityFocus:
                widget.semanticsProperties?.onDidGainAccessibilityFocus,
            onDidLoseAccessibilityFocus:
                widget.semanticsProperties?.onDidLoseAccessibilityFocus,
            onFocus: widget.semanticsProperties?.onFocus,
            onMoveCursorBackwardByCharacter:
                widget.semanticsProperties?.onMoveCursorBackwardByCharacter,
            onMoveCursorForwardByCharacter:
                widget.semanticsProperties?.onMoveCursorForwardByCharacter,
            onSetSelection: widget.semanticsProperties?.onSetSelection,
            onSetText: widget.semanticsProperties?.onSetText,
            child: Image(
              key: widget.imageProperties?.key,
              alignment: widget.imageProperties?.alignment ?? Alignment.center,
              width: widget.imageProperties?.width,
              height: widget.imageProperties?.height,
              color: widget.imageProperties?.color,
              colorBlendMode: widget.imageProperties?.colorBlendMode,
              fit: widget.imageProperties?.fit,
              repeat: widget.imageProperties?.repeat ?? ImageRepeat.noRepeat,
              centerSlice: widget.imageProperties?.centerSlice,
              matchTextDirection:
                  widget.imageProperties?.matchTextDirection ?? false,
              gaplessPlayback: widget.imageProperties?.gaplessPlayback ?? false,
              filterQuality:
                  widget.imageProperties?.filterQuality ?? FilterQuality.low,
              isAntiAlias: widget.imageProperties?.isAntiAlias ?? false,
              errorBuilder: widget.imageProperties?.errorBuilder,
              frameBuilder: widget.imageProperties?.frameBuilder,
              loadingBuilder: widget.imageProperties?.loadingBuilder,
              semanticLabel: widget.imageProperties?.semanticLabel,
              excludeFromSemantics:
                  widget.imageProperties?.excludeFromSemantics ?? false,
              opacity: widget.imageProperties?.opacity,
              image: widget.image,
            ),
          );
        });
  }

  @override
  void dispose() {
    WePhotoService.dispose();
    super.dispose();
  }
}
