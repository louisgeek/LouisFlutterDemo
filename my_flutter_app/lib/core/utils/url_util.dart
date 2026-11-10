import 'dart:convert';

class UrlUtil {
  static String toSortedQueryString(Map<String, dynamic> params) {
    // 按 key 排序
    final sortedMap = Map.fromEntries(
      params.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );

    // 转 JSON
    return jsonEncode(sortedMap);
  }
}
