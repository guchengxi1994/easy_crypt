// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

String replacePath(String s) {
  String filename = basename(s);
  return "easy_encrypt_upload/$filename";
}
