import 'package:fake_factory/src/enums.dart';

/// Builder Annotation
class Fakeable {
  const Fakeable();
}

const generateFake = Fakeable();

class FakeField {
  final FakeType? fakeType;
  final dynamic defaultValue;

  const FakeField({
    this.fakeType,
    this.defaultValue,
  });
}
