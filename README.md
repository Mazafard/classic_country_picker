# Classic Country Picker

[![Pub Version](https://img.shields.io/pub/v/classic_country_picker)](https://pub.dev/packages/classic_country_picker)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/mazafard/classic_country_picker.svg?style=social)](https://github.com/mazafard/classic_country_picker)

A highly customizable, elegant, and classic country picker for Flutter. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/95b96614-b530-471d-b318-41c146b00130" width="250" alt="Classic Country Picker Demo" />
</p>

`classic_country_picker` provides an easy way to let your users select a country from a visually pleasing dialog. You can show the country name, emoji flag, dial code, and ISO code. It works out-of-the-box on Android, iOS, macOS, Web, Windows, and Linux.

## Features

- 🌍 **Comprehensive Data:** Includes all countries with ISO codes, dial codes, and emoji flags.
- 🎨 **Highly Customizable:** Toggle the visibility of flags, dial codes, ISO codes, and customize text styles.
- 🔍 **Search Functionality:** Built-in search bar inside the picker dialog to easily find countries by name, dial code, or ISO code.
- 🚀 **Zero Dependencies:** Keeps your app lightweight and fast.
- 📱 **Cross-Platform:** Works on Android, iOS, macOS, Windows, Linux, and Web.

## Quick Start

Simply use the `ClassicCountryDropdown` widget anywhere in your app:

```dart
import 'package:classic_country_picker/classic_country_picker.dart';

ClassicCountryDropdown(
  onChanged: (Country country) {
    print('Selected: ${country.name} (${country.dialCode})');
  },
)
```

## API Reference

### `ClassicCountryDropdown`

The main widget. A tappable dropdown that opens the country picker dialog.

| Parameter | Type | Default | Description |
|---|---|---|---|
| `onChanged` | `ValueChanged<Country>?` | `null` | Called when a country is selected. |
| `initialCountry` | `Country?` | `null` | The initially selected country. |
| `showFlag` | `bool` | `true` | Whether to show the country flag emoji. |
| `showDialCode` | `bool` | `false` | Whether to show the dial code (e.g. `+1`). |
| `showName` | `bool` | `true` | Whether to show the country name. |
| `showCode` | `bool` | `false` | Whether to show the ISO code (e.g. `US`). |
| `textStyle` | `TextStyle?` | `null` | Text style for the selected item display. |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.symmetric(horizontal: 12, vertical: 8)` | Padding inside the dropdown container. |
| `decoration` | `BoxDecoration?` | `null` | Custom decoration for the dropdown container. |
| `dialogBackgroundColor` | `Color?` | `null` | Background color of the picker dialog. |
| `searchHint` | `String` | `'Search country...'` | Hint text for the search bar. |

**Example — show only flag and dial code (phone input):**

```dart
ClassicCountryDropdown(
  showFlag: true,
  showName: false,
  showDialCode: true,
  showCode: false,
  onChanged: (country) {
    print('${country.dialCode}'); // +1
  },
)
```

**Example — show flag, name, and ISO code:**

```dart
ClassicCountryDropdown(
  showFlag: true,
  showName: true,
  showCode: true,
  showDialCode: false,
  onChanged: (country) {
    print('${country.name} (${country.code})'); // United States (US)
  },
)
```

---

### `CountryPickerDialog`

The dialog widget shown when the dropdown is tapped. Can also be used standalone via `showDialog`.

| Parameter | Type | Default | Description |
|---|---|---|---|
| `showFlag` | `bool` | `true` | Whether to show the flag emoji in each row. |
| `showDialCode` | `bool` | `true` | Whether to show the dial code in each row. |
| `showCode` | `bool` | `false` | Whether to show the ISO code as a subtitle. |
| `nameStyle` | `TextStyle?` | `null` | Custom text style for the country name. |
| `dialCodeStyle` | `TextStyle?` | `null` | Custom text style for the dial code. |
| `codeStyle` | `TextStyle?` | `null` | Custom text style for the ISO code. |
| `backgroundColor` | `Color?` | `null` | Background color of the dialog. |
| `searchHint` | `String` | `'Search country...'` | Hint text for the search input. |

---

### `showCountryPicker()`

A convenience function for showing the picker dialog. Drop-in replacement for `showCountryPicker` from other popular packages.

| Parameter | Type | Default | Description |
|---|---|---|---|
| `context` | `BuildContext` | **required** | The build context. |
| `onSelect` | `ValueChanged<Country>` | **required** | Called when a country is selected. |
| `showPhoneCode` | `bool` | `false` | Whether to show dial codes in the picker list. |

```dart
showCountryPicker(
  context: context,
  showPhoneCode: true,
  onSelect: (Country country) {
    print('${country.name}: ${country.dialCode}');
  },
);
```

---

### `Country` Model

The data model returned when a country is selected.

| Property | Type | Description |
|---|---|---|
| `name` | `String` | Country name (e.g. `"United States"`). |
| `code` | `String` | ISO 3166-1 alpha-2 code (e.g. `"US"`). |
| `dialCode` | `String` | International dial code (e.g. `"+1"`). |
| `flagEmoji` | `String` | Unicode flag emoji (e.g. `"🇺🇸"`). |
| `countryCode` | `String` | Alias for `code` (backward compatibility). |

---

### `CountryParser`

A utility class for looking up countries by their ISO code.

```dart
final country = CountryParser.parseCountryCode('DE');
print(country.name); // Germany
```

---

### `CountryData`

Access the full list of countries directly:

```dart
final allCountries = CountryData.countries;
print('Total countries: ${allCountries.length}');
```

## Customization Example

```dart
ClassicCountryDropdown(
  showFlag: true,
  showDialCode: true,
  showName: true,
  showCode: false,
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.blueAccent),
    boxShadow: [
      BoxShadow(color: Colors.black12, blurRadius: 4),
    ],
  ),
  onChanged: (country) {
    // Handle selection
  },
)
```

## AI Integration Guide

> This section is written for AI coding assistants (Gemini, Claude, Copilot, etc.)
> so they can generate correct `classic_country_picker` code on the first try.

### Import

```dart
import 'package:classic_country_picker/classic_country_picker.dart';
```

This single import gives you: `Country`, `CountryData`, `CountryParser`, `ClassicCountryDropdown`, `CountryPickerDialog`, and `showCountryPicker`.

### Common Patterns

**1. Dropdown in a form (show flag + name, no dial code):**

```dart
ClassicCountryDropdown(
  showFlag: true,
  showName: true,
  showDialCode: false, // default
  showCode: false,     // default
  onChanged: (Country country) {
    // country.name, country.code, country.dialCode, country.flagEmoji
  },
)
```

**2. Phone number input (flag + dial code only):**

```dart
ClassicCountryDropdown(
  showFlag: true,
  showName: false,
  showDialCode: true,
  onChanged: (Country country) {
    setState(() => _dialCode = country.dialCode); // e.g. "+1"
  },
)
```

**3. Show picker as a dialog (migration from other packages):**

```dart
showCountryPicker(
  context: context,
  showPhoneCode: true, // false = hide dial codes in list
  onSelect: (Country country) {
    // handle selection
  },
);
```

**4. Pre-select a country by ISO code:**

```dart
final country = CountryParser.parseCountryCode('DE'); // returns Country?
ClassicCountryDropdown(
  initialCountry: country,
  onChanged: (c) {},
)
```

**5. Access the full country list:**

```dart
final all = CountryData.countries; // List<Country>
```

### Country Model Shape

```dart
Country(
  name: 'Germany',       // required String
  code: 'DE',            // required String (ISO 3166-1 alpha-2)
  dialCode: '+49',       // required String (starts with +)
  flagEmoji: '🇩🇪',      // required String (unicode emoji)
)
// Also has: .countryCode (alias for .code), .toJson(), Country.fromJson()
```

### Default Values Summary

| Widget / Function | Parameter | Default |
|---|---|---|
| `ClassicCountryDropdown` | `showFlag` | `true` |
| `ClassicCountryDropdown` | `showName` | `true` |
| `ClassicCountryDropdown` | `showDialCode` | `false` |
| `ClassicCountryDropdown` | `showCode` | `false` |
| `CountryPickerDialog` | `showFlag` | `true` |
| `CountryPickerDialog` | `showDialCode` | `true` |
| `CountryPickerDialog` | `showCode` | `false` |
| `showCountryPicker` | `showPhoneCode` | `false` |

## Additional Information

For a complete runnable example, please check the `example` folder in the repository.

### Reporting Issues
If you encounter any bugs or have feature requests, please file an issue on the [GitHub repository](https://github.com/mazafard/classic_country_picker/issues).
