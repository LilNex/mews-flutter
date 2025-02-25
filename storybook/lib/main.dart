import 'package:flutter/material.dart';
import 'package:storybook/stories/avatar.dart';
import 'package:storybook/stories/badge.dart';
import 'package:storybook/stories/banner.dart';
import 'package:storybook/stories/button/button.dart';
import 'package:storybook/stories/button/dropdown.dart';
import 'package:storybook/stories/button/icon.dart';
import 'package:storybook/stories/button/split.dart';
import 'package:storybook/stories/card.dart';
import 'package:storybook/stories/chat/bubble.dart';
import 'package:storybook/stories/chat/chat.dart';
import 'package:storybook/stories/checkbox.dart';
import 'package:storybook/stories/checkbox_group.dart';
import 'package:storybook/stories/date_time_field.dart';
import 'package:storybook/stories/dialog.dart';
import 'package:storybook/stories/form/form_story.dart';
import 'package:storybook/stories/icon.dart';
import 'package:storybook/stories/icon_list.dart';
import 'package:storybook/stories/input.dart';
import 'package:storybook/stories/list_tile.dart';
import 'package:storybook/stories/loader.dart';
import 'package:storybook/stories/nested_overlays.dart';
import 'package:storybook/stories/nonmodal_wrapper.dart';
import 'package:storybook/stories/number_picker.dart';
import 'package:storybook/stories/radio.dart';
import 'package:storybook/stories/search_field.dart';
import 'package:storybook/stories/segmented_control.dart';
import 'package:storybook/stories/select_input.dart';
import 'package:storybook/stories/slidable.dart';
import 'package:storybook/stories/spacing.dart';
import 'package:storybook/stories/stack.dart';
import 'package:storybook/stories/standalone_link.dart';
import 'package:storybook/stories/step_bar.dart';
import 'package:storybook/stories/tabs.dart';
import 'package:storybook/stories/tags.dart';
import 'package:storybook/stories/typography/caption.dart';
import 'package:storybook/stories/typography/highlight.dart';
import 'package:storybook/stories/typography/label.dart';
import 'package:storybook/stories/typography/paragraph.dart';
import 'package:storybook/stories/typography/title.dart';
import 'package:storybook/stories/wide_banner.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Storybook(
        plugins: initializePlugins(
          contentsSidePanel: true,
          knobsSidePanel: true,
        ),
        stories: [
          formStory,
          avatarStory,
          button,
          dropdownButton,
          iconButton,
          splitButton,
          selectInputStory,
          checkbox,
          checkboxGroup,
          inputStory,
          searchFieldStory,
          numberPickerStory,
          spacingStory,
          tagStory,
          bannerStory,
          wideBannerStory,
          interactiveTagStory,
          iconStory,
          supplementaryIconStory,
          iconListStory,
          cardStory,
          nestedCardStory,
          radioStory,
          radioGroupStory,
          dialogStory,
          nonModalDialogStory,
          stackStory,
          stepBarStory,
          badgeStory,
          listTileStory,
          tabs,
          segmentedControlStory,
          slidableStory,
          nestedSelectStory,
          nestedSearchStory,
          nestedNonModalDialogStory,
          titleStory,
          paragraphStory,
          labelStory,
          captionStory,
          highlightStory,
          chatStory,
          chatBubbleStory,
          link,
          loaderStory,
          dateTimeFieldStory,
        ],
      );
}
