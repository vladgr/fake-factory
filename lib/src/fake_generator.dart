import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:fake_factory/src/fakeable.dart';
import 'package:source_gen/source_gen.dart';

import 'model_visitor.dart';

class FakeGenerator extends GeneratorForAnnotation<Fakeable> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    element.enclosingElement?.visitChildren(visitor);

    assert(visitor.parentFields != null);

    final className = visitor.className.replaceFirst('_', '');

    final buffer = StringBuffer();

    buffer.writeln('class $className extends ${visitor.className} {');

    buffer.writeln('Map<String, dynamic> variables = {};');

    buffer.writeln('$className() {');

    for (final field in visitor.parentFields!.keys) {
      // print(field);
      // print(field.runtimeType);

      // remove '_' from private variables
      final variable =
          field.startsWith('_') ? field.replaceFirst('_', '') : field;

      buffer.writeln("variables['$variable'] = super.$field;");
    }

    buffer.writeln('}');
    doSomethingElse1(visitor, buffer);
    doSomethingElse2(visitor, buffer);
    buffer.writeln('}');

    return buffer.toString();
  }

  void doSomethingElse1(ModelVisitor visitor, StringBuffer buffer) {}
  void doSomethingElse2(ModelVisitor visitor, StringBuffer buffer) {}
}
