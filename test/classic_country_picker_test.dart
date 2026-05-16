import 'package:flutter_test/flutter_test.dart';
import 'package:classic_country_picker/classic_country_picker.dart';

void main() {
  test('Country list is not empty', () {
    expect(CountryData.countries.isNotEmpty, true);
  });
}
