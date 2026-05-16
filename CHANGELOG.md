## 1.0.9

* Applied `dart format` across the entire codebase for consistent code style.
* Updated changelog for all missing versions.

## 1.0.8

* Reformatted `country_data.dart`, example app, and test suite to comply with Dart formatting standards.

## 1.0.7

* Upgraded Dart SDK to 3.11.5 and `flutter_lints` to 6.0.0.
* Added CI workflow with matrix testing across Linux, macOS, and Windows with iOS/Android build checks.
* Added pre-commit hook for automated quality gates.
* Added GitHub Actions automated publishing via OIDC.

## 1.0.6

* Added comprehensive test suite (33 tests covering model, data, parser, and widgets).
* Added full API reference and AI integration guide to README.

## 1.0.5

* Added `showPhoneCode` optional parameter to `showCountryPicker` function to hide the country dial code in the dropdown by default, ensuring full backwards-compatibility with existing packages.

## 1.0.4

* Fixed GitHub Actions automated publishing.

## 1.0.3

* Upgraded minimum Dart SDK requirement to `^3.6.0`.
* Upgraded `flutter_lints` to version 6.

## 1.0.2

* Fixed compilation issue in `showCountryPicker` function.

## 1.0.1

* Added `showCountryPicker` function for easier migration from older country picker packages.
* Added `countryCode` getter to `Country` model for easier migration.
* Added `CountryParser` utility class to parse countries from their ISO codes.

## 1.0.0

* Initial release of `classic_country_picker`.
* Added `ClassicCountryDropdown` widget.
* Added `CountryPickerDialog` with search functionality.
* Included comprehensive dataset of countries with ISO codes, dial codes, and emoji flags.
* Full cross-platform support (Android, iOS, Web, macOS, Windows, Linux).
