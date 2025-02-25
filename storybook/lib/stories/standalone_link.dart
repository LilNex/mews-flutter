import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story link = Story(
  name: 'Link/Standalone link',
  builder: (context) {
    final k = context.knobs;

    return SingleChildScrollView(
      child: Column(
        children: OptimusLinkSize.values
            .map(
              (size) => Padding(
                padding: const EdgeInsets.all(8),
                child: OptimusStandaloneLink(
                  onPressed:
                      k.boolean(label: 'Enabled', initial: true) ? () {} : null,
                  text: k.text(label: 'Text', initial: 'Link'),
                  size: size,
                  color: k.options(
                    label: 'Color',
                    initial: null,
                    options: _colors,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  },
);

const _colors = [
  Option(label: 'black', value: OptimusLightColors.neutral1000),
  Option(label: 'green', value: OptimusLightColors.success),
  Option(label: 'red', value: OptimusLightColors.danger),
];
