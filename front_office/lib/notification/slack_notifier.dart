// ignore_for_file: constant_identifier_names

/*class SlackNotifier {
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

import 'dart:convert';
import 'package:slack_notifier/slack_notifier.dart';
import 'package:http/http.dart' as http;

class SlackNotifierService {
  static const String _SLACK_WEBHOOK_URL =
      'https://hooks.slack.com/services/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';

  static Future<String> sendMessage(
    String text, {
    String? channel,
    String? iconEmoji,
    String? iconUrl,
    String? username,
    List<Map<String, dynamic>>? blocks,
    List<Attachment>? attachments,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_SLACK_WEBHOOK_URL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'Attchment': Attachment}),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to send Slack notification. Error: ${response.statusCode}');
      }

      return 'Slack notification sent successfully.';
    } catch (e) {
      print('Error sending Slack notification: $e');
    }

    throw Exception('Failed to send Slack notification.');
  }
}





/*
import 'package:http/http.dart' as http;
import 'dart:convert';

class SlackNotifierService {
  static const String _baseUrl =
      'https://hooks.slack.com/services/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';
  static const String _token =
      'xoxb-5252795059074-5238253742087-ucGPOSlxB41ig1DJtaecVE7m';

  static Future<String> sendMessage(
    String text, {
    String? channel,
    String? iconEmoji,
    String? iconUrl,
    String? username,
    List<Map<String, dynamic>>? blocks,
    List<Map<String, dynamic>>? attachments,
  }) async {
    final headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $_token',
    };

    final body = {
      'text': text,
      'channel': channel ?? '#general',
      'icon_emoji': iconEmoji ?? ':robot_face:',
      'icon_url': iconUrl,
      'username': username ?? 'Slack Notifier',
      'blocks': blocks,
      'attachments': attachments,
    };

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return 'Message sent successfully';
    } else {
      return 'Failed to send message';
    }
  }
}
*/