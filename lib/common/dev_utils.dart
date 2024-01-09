import 'dart:io';

class DevUtils {
  static Directory get executableDir =>
      File(Platform.resolvedExecutable).parent;
  static String cachePath = "${DevUtils.executableDir.path}/cache/";
}
