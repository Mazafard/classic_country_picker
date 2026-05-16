import '../data/country_data.dart';
import '../models/country.dart';

/// Helper class to parse countries from codes, making migration from other packages easier.
class CountryParser {
  /// Parses a country code into a [Country] object.
  /// Returns null if the country is not found.
  static Country? parseCountryCode(String code) {
    try {
      return CountryData.countries.firstWhere(
        (country) => country.code.toLowerCase() == code.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }
}
