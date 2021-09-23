// ignore_for_file: unused_element

class CacheService {
  // Key: class name, value latest id.
  static final Map<String, int> primaryKeyMap = {};

  static int incrementPrimaryKey(String className) {
    if (!primaryKeyMap.containsKey(className)) {
      int value = 1;
      primaryKeyMap[className] = value;
      return value;
    }

    int value = primaryKeyMap[className]!;
    value++;
    primaryKeyMap[className] = value;
    return value;
  }
}
