import 'package:flutter/material.dart';
import '../models/country.dart';
import 'country_picker_dialog.dart';

/// A highly customizable classic dropdown widget for selecting a country.
class ClassicCountryDropdown extends StatefulWidget {
  /// Called when a country is selected.
  final ValueChanged<Country>? onChanged;

  /// The initially selected country.
  final Country? initialCountry;

  /// Whether to show the country flag.
  final bool showFlag;

  /// Whether to show the country dial code.
  final bool showDialCode;

  /// Whether to show the country name.
  final bool showName;

  /// Whether to show the country ISO code.
  final bool showCode;

  /// Text style for the selected item.
  final TextStyle? textStyle;

  /// Custom padding for the dropdown container.
  final EdgeInsetsGeometry padding;

  /// Decoration for the dropdown container.
  final BoxDecoration? decoration;

  /// Background color of the picker dialog.
  final Color? dialogBackgroundColor;

  /// Hint text for the search bar inside the dialog.
  final String searchHint;

  /// Creates a [ClassicCountryDropdown].
  const ClassicCountryDropdown({
    super.key,
    this.onChanged,
    this.initialCountry,
    this.showFlag = true,
    this.showDialCode = false,
    this.showName = true,
    this.showCode = false,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.decoration,
    this.dialogBackgroundColor,
    this.searchHint = 'Search country...',
  });

  @override
  State<ClassicCountryDropdown> createState() => _ClassicCountryDropdownState();
}

class _ClassicCountryDropdownState extends State<ClassicCountryDropdown> {
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialCountry;
  }

  void _showPickerDialog() async {
    final selected = await showDialog<Country>(
      context: context,
      builder: (context) {
        return CountryPickerDialog(
          showFlag: widget.showFlag,
          showDialCode: widget.showDialCode,
          showCode: widget.showCode,
          backgroundColor: widget.dialogBackgroundColor,
          searchHint: widget.searchHint,
        );
      },
    );

    if (selected != null && selected != _selectedCountry) {
      setState(() {
        _selectedCountry = selected;
      });
      if (widget.onChanged != null) {
        widget.onChanged!(selected);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showPickerDialog,
      borderRadius:
          widget.decoration?.borderRadius?.resolve(Directionality.of(context)),
      child: Container(
        padding: widget.padding,
        decoration: widget.decoration ??
            BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_selectedCountry == null)
              Text('Select Country', style: widget.textStyle)
            else ...[
              if (widget.showFlag) ...[
                Text(_selectedCountry!.flagEmoji,
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
              ],
              if (widget.showName) ...[
                Text(_selectedCountry!.name, style: widget.textStyle),
                const SizedBox(width: 8),
              ],
              if (widget.showCode) ...[
                Text(_selectedCountry!.code, style: widget.textStyle),
                const SizedBox(width: 8),
              ],
              if (widget.showDialCode) ...[
                Text(_selectedCountry!.dialCode, style: widget.textStyle),
                const SizedBox(width: 8),
              ],
            ],
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
