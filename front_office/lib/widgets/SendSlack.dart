// ignore_for_file: file_names

/*import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SendMail extends StatefulWidget {
  const SendMail({super.key});

  @override
  State<SendMail> createState() => _SendMailState();
}

final toMailController = TextEditingController();
final subjectMailController = TextEditingController();
final textMailController = TextEditingController();
@override
Widget build(BuildContext context) {
  return Container();
}

Future<void> sendMail() async {
  String username = "iskanderhablenie@gmail.com"; // Your Email
  String password = "ifuxqlfgfebtvhlo"; // Your Email Password

  //Create Gmail Server
  // ignore: deprecated_member_use
  final smtpServer = gmail(username, password);

  // Create Gmail Message
  final message = Message()
    ..from = Address(username)
    ..recipients.add(toMailController.text);
  //..ccRecipients.addAll(['abc@gmail.com','pqr@gmail.com','...'])
  //..bccRecipients.add('...')
  //..subject = subjectController.text
  //..text = textController.text;

  try {
    final sendReport = await send(message, smtpServer).then((value) => clear());
    print('Message Sent:' + sendReport.toString());
  } catch (e) {
    print('Message not sent:' + e.toString());
  }
}

clear() {
  toMailController.text = '';
  //subjectController.text = '';
  //textController.text = '';
}

class _SendMailState extends State<SendMail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mail Send')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: toMailController,
              decoration: InputDecoration(
                hintText: "Please Enter To Mail Address",
                labelText: "To Mail",
              ),
            ),
            /*   TextFormField(
              controller: subjectController,
              decoration: InputDecoration(
                hintText: "Please Enter Subject",
                labelText: "Subject",
              ),
            ),
            TextFormField(
              controller: textController,
              decoration: InputDecoration(
                hintText: "Please Enter Text",
                labelText: "Text",
              ),
              minLines: 5,
              maxLines: 8,
            ),*/
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                      onPressed: sendMail,
                      icon: Icon(Icons.send),
                      label: Text('Send')),
                  TextButton.icon(
                      onPressed: clear,
                      icon: Icon(Icons.clear),
                      label: Text('clear'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/

/*import 'dart:convert';
import 'package:http/http.dart' as http;

class Attachment {
  Attachment({
    this.authorIcon,
    this.authorLink,
    this.authorName,
    this.color,
    this.fallback,
    this.fields,
    this.footer,
    this.footerIcon,
    this.imageUrl,
    this.pretext,
    this.text,
    this.thumbUrl,
    this.title,
    this.titleLink,
    this.ts,
  });

  /// A valid URL that displays a small 16px by 16px image to the left of the `authorName` text.
  /// Will only work if `authorName` is present.
  final String? authorIcon;

  /// A valid URL that will hyperlink the `authorName` text.
  /// Will only work if `authorName` is present.
  final String? authorLink;

  /// Small text used to display the author's name.
  final String? authorName;

  /// Changes the color of the border on the left side of this attachment from the default gray.
  /// Can either be one of `good` (green), `warning` (yellow), `danger` (red), or any hex color code (eg. `#439FE0`).
  final String? color;

  /// A plain text summary of the attachment used in clients that don't show formatted text (eg. IRC, mobile notifications).
  final String? fallback;

  /// An array of field objects that get displayed in a table-like way.
  /// For best results, include no more than 2-3 field objects.
  final List<Field>? fields;

  /// Some brief text to help contextualize and identify an attachment.
  /// Limited to 300 characters, and may be truncated further when displayed to users in environments with limited screen real estate.
  final String? footer;

  /// A valid URL to an image file that will be displayed beside the `footer` text.
  /// Will only work if `authorName` is present.
  /// We'll render what you provide at 16px by 16px.
  /// It's best to use an image that is similarly sized.
  final String? footerIcon;

  /// A valid URL to an image file that will be displayed at the bottom of the attachment.
  /// We support GIF, JPEG, PNG, and BMP formats.
  ///
  /// Large images will be resized to a maximum width of 360px or a maximum height of 500px, while still maintaining the original aspect ratio.
  /// Cannot be used with `thumbUrl`.
  final String? imageUrl;

  /// Text that appears above the message attachment block.
  final String? pretext;

  /// The main body text of the attachment.
  /// The content will automatically collapse if it contains 700+ characters or 5+ linebreaks, and will display a "Show more..." link to expand the content.
  final String? text;

  /// A valid URL to an image file that will be displayed as a thumbnail on the right side of a message attachment.
  /// We currently support the following formats: GIF, JPEG, PNG, and BMP.
  ///
  /// The thumbnail's longest dimension will be scaled down to 75px while maintaining the aspect ratio of the image.
  /// The filesize of the image must also be less than 500 KB.
  ///
  /// For best results, please use images that are already 75px by 75px.
  final String? thumbUrl;

  /// Large title text near the top of the attachment.
  final String? title;

  /// A valid URL that turns the `title` text into a hyperlink.
  final String? titleLink;

  /// An integer Unix timestamp that is used to related your attachment to a specific time.
  /// The attachment will display the additional timestamp value as part of the attachment's footer.
  ///
  /// Your message's timestamp will be displayed in varying ways, depending on how far in the past or future it is, relative to the present.
  /// Form factors, like mobile versus desktop may also transform its rendered appearance.
  final int? ts;

  Map<dynamic, dynamic> toMap() {
    var attachment = {};
    if (authorIcon != null) attachment['author_icon'] = authorIcon;
    if (authorLink != null) attachment['author_link'] = authorLink;
    if (authorName != null) attachment['author_name'] = authorName;
    if (color != null) attachment['color'] = color;
    if (fallback != null) attachment['fallback'] = fallback;
    if (fields != null) {
      attachment['fields'] = fields!.map((f) => f.toMap()).toList();
    }
    if (footer != null) attachment['footer'] = footer;
    if (footerIcon != null) attachment['footer_icon'] = footerIcon;
    if (imageUrl != null) attachment['image_url'] = imageUrl;
    if (pretext != null) attachment['pretext'] = pretext;
    if (text != null) attachment['text'] = text;
    if (thumbUrl != null) attachment['thumb_url'] = thumbUrl;
    if (title != null) attachment['title'] = title;
    if (titleLink != null) attachment['title_link'] = titleLink;
    if (ts != null) attachment['ts'] = ts;

    return attachment;
  }
}

class Field {
  Field({this.title, this.value, this.short});

  /// Shown as a bold heading displayed in the field object.
  final String? title;

  /// The text value displayed in the field object.
  final String? value;

  /// Indicates whether the field object is short enough to be displayed side-by-side with other field objects.
  /// Defaults to `false`.
  final bool? short;

  Map<dynamic, dynamic> toMap() {
    var field = {};
    if (title != null) field['title'] = title;
    if (value != null) field['value'] = value;
    if (short != null) field['short'] = short;

    return field;
  }
}

abstract class Block {
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

class SlackNotifier {
  SlackNotifier(this.token);

  /// Webhook URL that is specific to a single user and a single channel.
  final String token;

  /// Send message to your slack workspace.
  Future<String> send(
    String text, {
    String? channel,
    String? iconEmoji,
    String? iconUrl,
    String? username,
    List<Block>? blocks,
    List<Attachment>? attachments,
  }) async {
    var webhookUrl = token.startsWith('https')
        ? token
        : 'https://hooks.slack.com/services/$token';

    var body = {'text': text, 'link_names': true};
    if (channel != null) body['channel'] = channel;
    if (iconEmoji != null) body['icon_emoji'] = iconEmoji;
    if (iconUrl != null) body['icon_url'] = iconUrl;
    if (username != null) body['username'] = username;
    if (blocks != null) {
      body['blocks'] = blocks.map((b) => b.toMap()).toList();
    }
    if (attachments != null) {
      body['attachments'] = attachments.map((a) => a.toMap()).toList();
    }

    var response = await http.post(
      Uri.parse(webhookUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return response.body;
  }
}
*/
import 'package:flutter/material.dart';
import 'package:slack_notifier/slack_notifier.dart';

class SendSlack extends StatelessWidget {
  const SendSlack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

void main() {
  final slack =
      SlackNotifier('T057EPD1R26/B057BR03A9K/xRYuZnUD53Rumm3ZEfVzaoF8');
  slack.send(
    'message',
    channel: 'general',
  );
}
