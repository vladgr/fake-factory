import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:fake_factory/src/enums.dart';
import 'package:fake_factory/src/fakeable.dart';
import 'package:fake_factory/src/services/helpers.dart';
import 'package:fake_factory/src/services/parse_utils.dart';
import 'package:source_gen/source_gen.dart';

import 'model_visitor.dart';

class FakeGenerator extends GeneratorForAnnotation<Fakeable> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    element.enclosingElement?.visitChildren(visitor);

    assert(visitor.factoryElement != null);
    assert(visitor.dataElement != null);

    final factoryClassName = visitor.factoryElement!.name;
    final dataClassName = visitor.dataElement!.name;

    final factoryFields = visitor.factoryElement!.fields;
    final dataFields = visitor.dataElement!.fields;

    // Remove '_' from class name.
    // Example: _UserFactory should become UserFactory
    final className = factoryClassName.replaceFirst('_', '');

    final buffer = StringBuffer();

    buffer.writeln('class $className extends $factoryClassName {');

    buffer.writeln('$dataClassName getInstance() {');

    for (final field in factoryFields) {
      final value = _getDefaultValue(field);
    }

    buffer.writeln('}');
    buffer.writeln('}');

    return buffer.toString();
  }

  /// Get value for annotated field with @FakeField
  dynamic _getDefaultValue(FieldElement field) {
    if (field.metadata.isEmpty) return null;

    final anot = field.metadata.first;
    final obj = anot.computeConstantValue();
    if (obj == null) return null;

    final cr = ConstantReader(obj);

    final fakeTypeAnotation = cr.read('fakeType');
    final defaultValueAnotation = cr.read('defaultValue');

    if (!fakeTypeAnotation.isNull) {
      // print(fakeTypeAnotation.objectValue);
    }

    if (!defaultValueAnotation.isNull) {
      print(ParseUtils.literalForObject(defaultValueAnotation.objectValue));
    }

    // if (defaultValue != null && !defaultValue.isNull) {
    //   final value = ParseUtils.literalForObject(defaultValue, []);
    //   // print(value);
    // }
  }
}
