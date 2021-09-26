import 'package:html/parser.dart';

extension ParseHtml on String{
  String parseHtmlToString() {
    final document = parse(this);
    final String parsedString = parse(document.body?.text).documentElement?.text ?? '';
    return parsedString;
  }

}