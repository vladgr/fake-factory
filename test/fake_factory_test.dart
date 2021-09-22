@TestOn('vm')
import 'package:fake_factory/src/fake_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

Future<void> main() async {
  initializeBuildLogTracking();

  final reader = await initializeLibraryReaderForDirectory(
    p.join('test', 'src'),
    '_fake_factory_test_input.dart',
  );

  testAnnotatedElements(
    reader,
    FakeGenerator(),
    expectedAnnotatedTests: _expectedAnnotatedTests,
  );

  test('regular test', () {});
}

const _expectedAnnotatedTests = {
  '_UserFactory',
};
