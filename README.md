# Classic Country Picker

![Demo](assets/demo.webp)

A highly customizable, elegant, and classic country picker for Flutter. 

`classic_country_picker` provides an easy way to let your users select a country from a visually pleasing dialog. You can show the country name, emoji flag, dial code, and ISO code. It works out-of-the-box on Android, iOS, macOS, Web, Windows, and Linux.

## Features

- 🌍 **Comprehensive Data:** Includes all countries with ISO codes, dial codes, and emoji flags.
- 🎨 **Highly Customizable:** Toggle the visibility of flags, dial codes, ISO codes, and customize text styles.
- 🔍 **Search Functionality:** Built-in search bar inside the picker dialog to easily find countries by name, dial code, or ISO code.
- 🚀 **Zero Dependencies:** Keeps your app lightweight and fast.
- 📱 **Cross-Platform:** Works on Android, iOS, macOS, Windows, Linux, and Web.

## Usage

Simply use the `ClassicCountryDropdown` widget anywhere in your app:

```dart
import 'package:flutter/material.dart';
import 'package:classic_country_picker/classic_country_picker.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClassicCountryDropdown(
        showFlag: true,
        showDialCode: true,
        showName: true,
        showCode: false,
        onChanged: (Country country) {
          print('Selected: ${country.name} (${country.dialCode})');
        },
      ),
    );
  }
}
```

## Customization

You can customize almost every aspect of the `ClassicCountryDropdown`:

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

## Additional Information

For a complete runnable example, please check the `example` folder in the repository.

### Reporting Issues
If you encounter any bugs or have feature requests, please file an issue on the [GitHub repository](https://github.com/mazafard/classic_country_picker/issues).
