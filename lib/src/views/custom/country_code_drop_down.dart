import 'package:az_banking_app/src/views/custom/custom_text.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class DialCountry {
  final String iso;      // "AE"
  final String name;     // "United Arab Emirates"
  final String countryCode; // "+971"

  const DialCountry({required this.iso, required this.name, required this.countryCode});

  CountryFlag get flag => CountryFlag.fromCountryCode(iso, shape: Circle(),);

  @override
  String toString() => countryCode;

  @override
  bool operator ==(Object other) => other is DialCountry && other.iso == iso;
  @override
  int get hashCode => iso.hashCode;
}

/// Compact, Gulf-friendly defaults. Add more if you like.
const kDialCountries = <DialCountry>[
  DialCountry(iso: 'AE', name: 'United Arab Emirates', countryCode: '+971'),
  DialCountry(iso: 'SD', name: 'Sudan',                countryCode: '+249'),
  DialCountry(iso: 'SA', name: 'Saudi Arabia',         countryCode: '+966'),
  DialCountry(iso: 'EG', name: 'Egypt',                countryCode: '+20'),
  DialCountry(iso: 'QA', name: 'Qatar',                countryCode: '+974'),
  DialCountry(iso: 'OM', name: 'Oman',                 countryCode: '+968'),
  DialCountry(iso: 'KW', name: 'Kuwait',               countryCode: '+965'),
  DialCountry(iso: 'BH', name: 'Bahrain',              countryCode: '+973'),
  DialCountry(iso: 'US', name: 'United States',        countryCode: '+1'),
  DialCountry(iso: 'GB', name: 'United Kingdom',       countryCode: '+44'),
];

class CountryCodeDropdownMenu extends StatefulWidget {
  final List<DialCountry> countries;
  final String initialIso; // e.g. "AE"
  final ValueChanged<DialCountry?>? onSelected;

  // Layout
  final double? width;
  final double? menuHeight;
  final String? label;

  const CountryCodeDropdownMenu({
    super.key,
    this.countries = kDialCountries,
    this.initialIso = 'SD',
    this.onSelected,
    this.width = 80,
    this.menuHeight,
    this.label,
  });

  @override
  State<CountryCodeDropdownMenu> createState() => _CountryCodeDropdownMenuState();
}

class _CountryCodeDropdownMenuState extends State<CountryCodeDropdownMenu> {
  late DialCountry _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.countries.firstWhere(
          (c) => c.iso.toUpperCase() == widget.initialIso.toUpperCase(),
      orElse: () => widget.countries.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: DropdownButtonFormField<DialCountry>(
        value: _selected,
        isExpanded: false,
        items: widget.countries
            .map((e) => DropdownMenuItem<DialCountry>(
          value: e,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomText.title(
              e.toString(),
              fontSize: 14.0,
              maxLines: 1,
            ),
          ),
        ))
            .toList(),
        onChanged: widget.onSelected,
        onSaved: widget.onSelected,
      ),
    );
  }
}
