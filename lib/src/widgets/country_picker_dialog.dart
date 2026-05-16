import 'package:flutter/material.dart';
import '../models/country.dart';
import '../data/country_data.dart';

/// A dialog that allows users to search and select a country.
class CountryPickerDialog extends StatefulWidget {
  /// Whether to show the country flag emoji.
  final bool showFlag;

  /// Whether to show the dial code.
  final bool showDialCode;

  /// Whether to show the ISO code.
  final bool showCode;

  /// Optional text style for the country name.
  final TextStyle? nameStyle;

  /// Optional text style for the dial code.
  final TextStyle? dialCodeStyle;

  /// Optional text style for the ISO code.
  final TextStyle? codeStyle;

  /// Background color of the dialog.
  final Color? backgroundColor;

  /// Hint text for the search input.
  final String searchHint;

  /// Creates a [CountryPickerDialog].
  const CountryPickerDialog({
    super.key,
    this.showFlag = true,
    this.showDialCode = true,
    this.showCode = false,
    this.nameStyle,
    this.dialCodeStyle,
    this.codeStyle,
    this.backgroundColor,
    this.searchHint = 'Search country...',
  });

  @override
  State<CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCountries = CountryData.countries;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCountries = CountryData.countries.where((country) {
        return country.name.toLowerCase().contains(query) ||
            country.code.toLowerCase().contains(query) ||
            country.dialCode.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor:
          widget.backgroundColor ?? DialogTheme.of(context).backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: widget.searchHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          const Divider(height: 1),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                return ListTile(
                  leading: widget.showFlag
                      ? Text(
                          country.flagEmoji,
                          style: const TextStyle(fontSize: 24),
                        )
                      : null,
                  title: Text(
                    country.name,
                    style: widget.nameStyle ??
                        const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: widget.showCode
                      ? Text(country.code, style: widget.codeStyle)
                      : null,
                  trailing: widget.showDialCode
                      ? Text(
                          country.dialCode,
                          style: widget.dialCodeStyle ??
                              TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color),
                        )
                      : null,
                  onTap: () {
                    Navigator.of(context).pop(country);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
