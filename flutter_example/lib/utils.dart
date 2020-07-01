import 'dart:convert';

import 'package:crypto/crypto.dart';
class Utils {
  static String getSHA256(String input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    print("Digest as bytes: ${digest.bytes}");
    print("Digest as hex string: ");
    return "$digest";
  }
}