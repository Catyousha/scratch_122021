import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class Cat {
  String sound() => 'Meow!';
  bool likes(
    String food, {
    bool isHungry = false,
  }) {
    return false;
  }

  final int lives = 9;
}

class MockCat extends Mock implements Cat {}

void main() {
  group('Basic test', () {
    var str = 'hello world';
    test('str equals hello world', () {
      expect(str, equals("hello world"));
    });
    test('str is not equals foobar', () {
      expect(str, isNot(equals("foobar")));
    });
    test('int parse fails', () {
      expect(() => int.parse('foo'), throwsFormatException);
    });
  });

  group('Basic mocktail:', () {
    final cat = MockCat();

    // stub method
    test('cat sounds purr', () {
      when(() => cat.sound()).thenReturn('purr');
      var result = cat.sound();
      expect(result, equals('purr'));
    });

    // stub getter
    test('cat lives is 10', () {
      when(() => cat.lives).thenReturn(10);
      var result = cat.lives;
      expect(result, equals(10));
    });

    // stub method + arguments & count calling
    test('cat likes fish', () {
      when(() => cat.likes('fish', isHungry: false)).thenReturn(true);
      var result = cat.likes('fish', isHungry: false);
      verify(() => cat.likes('fish', isHungry: false)).called(1);
      expect(result, equals(true));
    });

    // catch arguments
    test('cat likes fish 2', () {
      when(() => cat.likes('fish')).thenReturn(true);
      var result = cat.likes('fish');
      var result2 = cat.likes('fish');
      final captured = verify(() => cat.likes(captureAny())).captured;
      expect(captured, equals(['fish', 'fish']));
    });

    // capture specific arguments
    test('cat likes fish & whiskas', () {
      // apapun argsnya, returnnya mesti true
      when(() => cat.likes(any())).thenReturn(true);
      var result = cat.likes('fish');
      var result2 = cat.likes('whiskas');
      final captured =
          verify(() => cat.likes((captureAny(that: startsWith('w'))))).captured;
      expect(captured, equals(['whiskas']));
    });
  });
}
