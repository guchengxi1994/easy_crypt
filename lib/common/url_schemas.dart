import 'package:url_launcher/url_launcher.dart';

class UrlSchema {
  String? icon;
  String urlSchema;

  UrlSchema({this.icon, required this.urlSchema});

  Future launch() async {
    final Uri url = Uri.parse(urlSchema);
    launchUrl(url);
  }
}

final wechatSchema = UrlSchema(urlSchema: "weixin://");
final emailSchema = UrlSchema(urlSchema: "mailto:");
