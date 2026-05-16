import 'package:flutter/material.dart';
import '../models/country.dart';
import 'country_picker_dialog.dart';

/// Shows a dialog containing a classic country picker.
///
/// This function acts as a drop-in replacement for `showCountryPicker` from other popular packages.
Future<Country?> showCountryPicker({
  required BuildContext context,
  required ValueChanged<Country> onSelect,
}) {
  return showDialog<Country>(
    context: context,
    builder: (BuildContext context) => const CountryPickerDialog(),
  ).then((country) {
    if (country != null) {
      onSelect(country);
    }
    return country;
  });
}
