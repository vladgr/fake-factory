// ignore_for_file: unused_element, overridden_fields, annotate_overrides

import 'package:fake_factory/fake_factory.dart';
import 'package:fake_factory/src/enums.dart';
import 'package:source_gen_test/annotations.dart';

class User {
  late final int id;
  late final String firstName;
  late final String someEmail;
  late final int someIntNumber;
}

@ShouldGenerate(
  r'''
class UserFactory extends _UserFactory {
  User getInstance() {}
}
''',
  configurations: ['default'],
)
@Fakeable()
class _UserFactory extends User {
  @FakeField(fakeType: FakeType.email)
  late final String someEmail;

  @FakeField(defaultValue: 1)
  late final int someIntNumber;
}
