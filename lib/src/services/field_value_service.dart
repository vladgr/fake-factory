// ignore_for_file: unused_element

import 'package:fake_factory/src/enums.dart';
import 'package:fake_factory/src/services/helpers.dart';
import 'package:faker/faker.dart';

/// Service to get fake value for field.
/// Returns value by name or by type.
class FieldValueService {
  static final _faker = Faker();

  static dynamic _getValue(String name, dynamic fieldType) {
    switch (name) {
      case 'firstName':
        return _faker.person.firstName();

      case 'lastName':
        return _faker.person.lastName();

      case 'email':
        return _faker.internet.email();

      case 'username':
        return _faker.internet.userName();

      case 'address':
        return _faker.address.streetAddress();

      case 'city':
        return _faker.address.city();

      case 'country':
        return _faker.address.country();

      case 'sentence':
        return _faker.lorem.sentence();

      case 'postCode':
        return _faker.address.zipCode();

      case 'url':
        return _faker.internet.httpsUrl();

      case 'httpUrl':
        return _faker.internet.httpUrl();

      case 'httpsUrl':
        return _faker.internet.httpsUrl();

      default:
        break;
    }

    switch (fieldType) {
      case int:
        return _faker.randomGenerator.integer(100);

      case double:
        return _faker.randomGenerator.decimal();

      case String:
        return _faker.lorem.word();

      case DateTime:
        return DateTime.now();

      default:
        break;
    }

    return null;
  }

  static dynamic getValue(
    String fieldName,
    dynamic fieldType,
    Map<String, FakeType>? map,
  ) {
    String name = fieldName;

    if (map != null && map.containsKey(fieldName)) {
      final ft = map[fieldName];
      name = Helpers.enumToString(ft);
    }

    return _getValue(name, fieldType);
  }
}
