import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

class ModelVisitor extends SimpleElementVisitor<dynamic> {
  late String className;
  Map<String, dynamic>? parentFields;

  Map<String, dynamic> fields = <String, dynamic>{};

  @override
  dynamic visitClassElement(ClassElement element) {
    // Parent should not starts with '_
    if (!element.name.startsWith('_')) {
      parentFields = {};

      for (final field in element.fields) {
        parentFields![field.name] = field.type;
      }
    }
  }

  @override
  dynamic visitConstructorElement(ConstructorElement element) {
    final elementReturnType = element.type.returnType.toString();

    // DartType ends with '*', which needs to be eliminated
    // for the generated code to be accurate.
    className = elementReturnType.replaceFirst('*', '');
  }

  @override
  dynamic visitFieldElement(FieldElement element) {
    final elementType = element.type.toString();

    // DartType ends with '*', which needs to be eliminated
    // for the generated code to be accurate.
    fields[element.name] = elementType.replaceFirst('*', '');
  }
}
