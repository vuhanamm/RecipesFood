extension ParseMap on Map {
  int toInt(String key) {
    final value = this[key];
    if (value != null && value is int) {
      return value;
    }
    return value;
  }

  bool toBool(String key) {
    final value = this[key];
    if (value != null && value is bool) {
      return value;
    }
    return value;
  }

  String parseString(String key) {
    final value = this[key];
    if (value != null && value is String) {
      return value;
    }
    return value;
  }

  double toDouble(String key) {
    final value = this[key];
    if (value != null && value is double) {
      return value;
    }
    return 0.0;
  }

  Map<String, dynamic> toMap(String key) {
    final map = this[key];
    if (map != null && map is Map<String, dynamic>) {
      return map;
    }
    return {};
  }

  List<dynamic> toList(String key){
    final list = this[key];
    if(list != null && list is List){
      return list;
    }
    return [];
  }
}
