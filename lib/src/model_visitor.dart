import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

class ModelVisitor extends SimpleElementVisitor<dynamic> {
  ClassElement? factoryElement;
  ClassElement? dataElement;

  /// Visits child and parent.
  /// Example: _UserFactory extends User.
  /// It visits both: _UserFactory (factory class) and User (data class).
  @override
  dynamic visitClassElement(ClassElement element) {
    final isChild = element.name.endsWith('Factory');

    if (isChild) {
      factoryElement = element;
    } else {
      dataElement = element;
    }
  }

  @override
  dynamic visitConstructorElement(ConstructorElement element) {
    // final elementReturnType = element.type.returnType.toString();
    // className = elementReturnType.replaceFirst('*', '');
  }

  @override
  dynamic visitFieldElement(FieldElement element) {}
}
