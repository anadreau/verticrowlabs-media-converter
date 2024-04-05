import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verticrowlabs_media_converter/features/media_conversion/media_conversion_barrel.dart';

///[List] of [MediaScale] values for use in [MediaDropDown]
final List<MediaScale> mediaScaleDropDownList = MediaScale.values.toList();

///[List] of [mediaScaleDropDownList] as [String] for use in [MediaDropDown]
final List<String> dropDownList =
    mediaScaleDropDownList.map((e) => e.resolution).toList();

///[ConsumerStatefulWidget] that returns a [DropdownButton] for selecting
///[MediaScale]
class MediaDropDown extends ConsumerStatefulWidget {
  ///Implementation of [MediaDropDown]
  const MediaDropDown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MediaDropDownState();
}

class _MediaDropDownState extends ConsumerState<MediaDropDown> {
  String dropdownValue = dropDownList.first;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: DropdownButton<String>(
          iconEnabledColor: theme.colorScheme.onPrimaryContainer,
          dropdownColor: theme.colorScheme.primaryContainer,
          focusColor: Colors.white.withOpacity(0),
          value: dropdownValue,
          items: dropDownList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text('${value}p'),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              dropdownValue = value!;

              log('dropdownValue: $dropdownValue');
              final scale = switch (dropdownValue) {
                '480' => MediaScale.low,
                '720' => MediaScale.medium,
                '1080' => MediaScale.high,
                _ => MediaScale.medium
              };
              ref.read(outputScaleSelector.notifier).update((state) => scale);
            });
          },
        ),
      ),
    );
  }
}
