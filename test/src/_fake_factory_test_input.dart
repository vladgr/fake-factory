// ignore_for_file: unused_element

import 'package:fake_factory/fake_factory.dart';
import 'package:source_gen_test/annotations.dart';

class User {
  late final int id;
  late final String firstName;
}

@ShouldGenerate(
  r'''
class UserFactory extends _UserFactory {
  Map<String, dynamic> variables = {};
  UserFactory() {
    variables['id'] = super.id;
    variables['firstName'] = super.firstName;
  }
}
''',
  configurations: ['default'],
)
@Fakeable()
class _UserFactory extends User {}
