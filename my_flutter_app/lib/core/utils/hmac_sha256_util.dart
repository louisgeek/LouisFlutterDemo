import 'dart:convert';
import 'package:crypto/crypto.dart';

class HmacSha256Util {
  static const _hexArray = '0123456789abcdef';

  // HMAC-SHA256 生成 Hex 编码的签名
  static String generateHMACSHA256Hex(int timestamp, String param, String accessKey, String secretKey) {
    try {
      // Step 1: 构造消息 accesskey + Timestamp + param
      final message = '$accessKey$timestamp$param';

      // Step 2: 生成 HMAC-SHA256
      final hmac = _hmacSHA256(message, secretKey);

      // Step 3: 将 HMAC-SHA256 结果转换为 Hex 编码
      return _bytesToHex(hmac);
    } catch (e) {
      return '';
    }
  }

  // 使用给定的 key 生成 HMAC-SHA256 签名
  static List<int> _hmacSHA256(String message, String secretKey) {
    final key = utf8.encode(secretKey);
    final bytes = utf8.encode(message);
    final hmacSha256 = Hmac(sha256, key);
    return hmacSha256.convert(bytes).bytes;
  }

  // 将字节数组转换为 Hex 编码的字符串
  static String _bytesToHex(List<int> bytes) {
    final hexChars = List<String>.filled(bytes.length * 2, '');
    for (int i = 0; i < bytes.length; i++) {
      int v = bytes[i] & 0xFF;
      // 高4位
      hexChars[i * 2] = _hexArray[v >>> 4];
      // 低4位
      hexChars[i * 2 + 1] = _hexArray[v & 0x0F];
    }
    return hexChars.join();
  }
}

// 使用示例
void main() {
  final timestamp = 1633045964;
  final signParam = '111111';
  final accessKey = 'your_access_key';
  final secretKey = 'your_secret_key';

  final hmacHex = HmacSha256Util.generateHMACSHA256Hex(
    timestamp,
    signParam,
    accessKey,
    secretKey,
  );
  print('HMAC-SHA256 Hex: $hmacHex');
}
