// ignore_for_file: unused_element
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

class ParseUtils {
  static String enumToString(Object? o) => o.toString().split('.').last;

  static T enumFromString<T>(String key, List<T> values) =>
      values.firstWhere((v) => key == enumToString(v));

  /// Can convert DartObject to object value.
  /// Only primitive supported.
  /// Todo: enums, custom objects.
  /// Consider to analyze code in json_serializable
  /// or use generic_reader package.
  static Object? literalForObject(DartObject dartObject) {
    if (dartObject.isNull) {
      return null;
    }

    final reader = ConstantReader(dartObject);

    String? badType;
    if (reader.isSymbol) {
      badType = 'Symbol';
    } else if (reader.isType) {
      badType = 'Type';
    } else if (!reader.isLiteral) {
      badType = dartObject.type!.element!.name;
    }

    if (badType != null) {
      return null;
    }

    if (reader.isDouble || reader.isInt || reader.isString || reader.isBool) {
      return reader.literalValue;
    }

    if (reader.isList) {
      return [for (var e in reader.listValue) literalForObject(e)];
    }

    if (reader.isSet) {
      return {for (var e in reader.setValue) literalForObject(e)};
    }

    if (reader.isMap) {
      return reader.mapValue.map(
        (k, v) => MapEntry(
          literalForObject(k!),
          literalForObject(v!),
        ),
      );
    }

    return null;
  }
}
