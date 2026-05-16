import 'package:flutter_test/flutter_test.dart';
import 'package:classic_country_picker/classic_country_picker.dart';

void main() {
  test('Country list is not empty', () {
    expect(CountryData.countries.isNotEmpty, true);
  });

  test('countryCode getter aliases code correctly', () {
    const country = Country(
      name: 'United States',
      code: 'US',
      dialCode: '+1',
      flagEmoji: '🇺🇸',
    );
    expect(country.countryCode, 'US');
    expect(country.countryCode, country.code);
  });

  test('CountryParser.parseCountryCode returns correct country', () {
    final us = CountryParser.parseCountryCode('US');
    expect(us, isNotNull);
    expect(us?.name, 'United States');

    final canadaLowercase = CountryParser.parseCountryCode('ca');
    expect(canadaLowercase, isNotNull);
    expect(canadaLowercase?.name, 'Canada');

    final invalid = CountryParser.parseCountryCode('INVALID');
    expect(invalid, isNull);
  });
}
