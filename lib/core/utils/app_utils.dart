import 'dart:math';

class AppUtils {
  static String generateRandomString(int length) {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final Random random = Random.secure();

    return List.generate(length, (index) {
      return chars[random.nextInt(chars.length)];
    }).join('');
  }
}
