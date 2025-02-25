import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story tagStory = Story(
  name: 'Tags/Tag',
  builder: (context) {
    final k = context.knobs;

    Widget buildTags(TagVersion version) => Wrap(
          children: OptimusColorOption.values
              .map(
                (c) => _PaddedTag(
                  version: version,
                  colorOption: c,
                  text: k.text(label: 'Text', initial: ''),
                ),
              )
              .toList(),
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const OptimusSectionTitle(child: Text('Bold')),
        buildTags(TagVersion.bold),
        const SizedBox(height: 20),
        const OptimusSectionTitle(child: Text('Subtle')),
        buildTags(TagVersion.subtle),
      ],
    );
  },
);

final Story interactiveTagStory = Story(
  name: 'Tags/Interactive tag',
  builder: (context) {
    final k = context.knobs;

    return OptimusInteractiveTag(
      text: k.text(label: 'Text', initial: 'Removable tag'),
      onRemoved: k.boolean(label: 'Enabled', initial: true) ? () {} : null,
    );
  },
);

class _PaddedTag extends StatelessWidget {
  const _PaddedTag({
    Key? key,
    required this.version,
    required this.colorOption,
    required this.text,
  }) : super(key: key);

  final TagVersion version;
  final OptimusColorOption colorOption;
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: OptimusTag(
          text: text.isEmpty ? describeEnum(colorOption) : text,
          colorOption: colorOption,
          version: version,
        ),
      );
}
