/*abstract class Block {
  Map<dynamic, dynamic> toMap();
}

/// A block that is used to hold interactive elements.
class ActionsBlock extends Block {
  ActionsBlock({required this.elements});

  /// An array of interactive element objects - buttons, select menus, overflow menus, or date pickers.
  /// There is a maximum of 5 elements in each action block.
  final List<Map> elements;

  @override
  toMap() => {'type': 'actions', 'elements': elements};
}

/// Displays message context, which can include both images and text.
class ContextBlock extends Block {
  ContextBlock({required this.elements});

  /// An array of image elements and text objects.
  /// Maximum number of items is 10.
  final List<Map> elements;

  @override
  toMap() => {'type': 'context', 'elements': elements};
}

/// A content divider to split up different blocks inside of a message.
class DividerBlock extends Block {
  @override
  toMap() => {'type': 'divider'};
}

/// Displays a remote file.
/// You can't add this block to app surfaces directly, but it will show up when retrieving messages that contain remote files.
class FileBlock extends Block {
  FileBlock({required this.externalId});

  /// The external unique ID for this file.
  final String externalId;

  @override
  toMap() => {'type': 'file', 'external_id': externalId, 'source': 'remote'};
}

/// A `header` is a plain-text block that displays in a larger, bold font.
/// Use it to delineate between different groups of content in your app's surfaces.
class HeaderBlock extends Block {
  HeaderBlock({required this.text});

  /// The text for the block.
  /// Maximum length for this field is 150 characters.
  final String text;

  @override
  toMap() => {
        'type': 'header',
        'text': {'type': 'plain_text', 'text': text}
      };
}

/// A simple image block, designed to make those cat photos really pop.
class ImageBlock extends Block {
  ImageBlock({required this.imageUrl, required this.altText, this.title});

  /// The URL of the image to be displayed.
  /// Maximum length for this field is 3000 characters.
  final String imageUrl;

  /// A plain-text summary of the image.
  /// Maximum length for this field is 2000 characters.
  final String altText;

  /// An optional title for the image.
  /// Maximum length for this field is 2000 characters.
  final String? title;

  @override
  toMap() {
    var block = {};
    block['type'] = 'image';
    block['image_url'] = imageUrl;
    block['alt_text'] = altText;
    if (title != null) block['title'] = {'type': 'plain_text', 'text': title};

    return block;
  }
}

/// A block that collects information from users - it can hold a plain-text input element, a checkbox element, a radio button element, a select menu element, a multi-select menu element, or a datepicker.
class InputBlock extends Block {
  InputBlock({required this.label, required this.element, this.hint});

  /// A label that appears above an input element.
  /// Maximum length for this field is 2000 characters.
  final String label;

  /// An plain-text input element, a checkbox element, a radio button element, a select menu element, a multi-select menu element, or a datepicker.
  final Map element;

  /// An optional hint that appears below an input element in a lighter grey.
  /// Maximum length for this field is 2000 characters.
  final String? hint;

  @override
  toMap() {
    var block = {};
    block['type'] = 'input';
    block['label'] = {'type': 'plain_text', 'text': label};
    block['element'] = element;
    if (hint != null) block['hint'] = {'type': 'plain_text', 'text': hint};

    return block;
  }
}

/// A `section` is one of the most flexible blocks available - it can be used as a simple text block, in combination with text fields, or side-by-side with any of the available block elements.
class SectionBlock extends Block {
  SectionBlock({this.text, this.fields, this.accessory});

  /// The text for the block.
  /// Maximum length for this field is 3000 characters.
  /// This field is not required if a valid array of `fields` objects is provided instead.
  final String? text;

  /// Required if no `text` is provided.
  /// Any text objects included with `fields` will be rendered in a compact format that allows for 2 columns of side-by-side text.
  /// Maximum number of items is 10.
  /// Maximum length for the `text` in each item is 2000 characters.
  final List<Map>? fields;

  /// One of the available element objects.
  final Map? accessory;

  @override
  toMap() {
    var block = {};
    block['type'] = 'section';
    if (text != null) block['text'] = {'type': 'mrkdwn', 'text': text};
    if (fields != null) block['fields'] = fields;
    if (accessory != null) block['accessory'] = accessory;

    return block;
  }
}
*/