import 'package:flutter/material.dart';
import '../models/country.dart';
import 'country_picker_dialog.dart';

/// Shows a dialog containing a classic country picker.
///
/// This function acts as a drop-in replacement for `showCountryPicker` from other popular packages.
Future<Country?> showCountryPicker({
  required BuildContext context,
  required ValueChanged<Country> onSelect,
  bool showPhoneCode = false,
}) {
  return showDialog<Country>(
    context: context,
    builder: (BuildContext context) => CountryPickerDialog(
      showDialCode: showPhoneCode,
    ),
  ).then((country) {
    if (country != null) {
      onSelect(country);
    }
    return country;
  });
}
