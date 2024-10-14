import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clicker/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.capybaraBlueSuit).existsSync(), isTrue);
    expect(File(Images.capybaraWithRedScarf).existsSync(), isTrue);
    expect(File(Images.cuteCapybaraCloth).existsSync(), isTrue);
  });
}
