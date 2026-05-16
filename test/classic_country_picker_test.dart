import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:classic_country_picker/classic_country_picker.dart';

void main() {
  // ─── Country Model ──────────────────────────────────────────────────

  group('Country model', () {
    test('constructor requires all fields', () {
      const country = Country(
        name: 'Germany',
        code: 'DE',
        dialCode: '+49',
        flagEmoji: '🇩🇪',
      );
      expect(country.name, 'Germany');
      expect(country.code, 'DE');
      expect(country.dialCode, '+49');
      expect(country.flagEmoji, '🇩🇪');
    });

    test('countryCode getter aliases code', () {
      const country = Country(
        name: 'United States',
        code: 'US',
        dialCode: '+1',
        flagEmoji: '🇺🇸',
      );
      expect(country.countryCode, equals(country.code));
      expect(country.countryCode, 'US');
    });

    test('equality compares all fields', () {
      const a = Country(
        name: 'France',
        code: 'FR',
        dialCode: '+33',
        flagEmoji: '🇫🇷',
      );
      const b = Country(
        name: 'France',
        code: 'FR',
        dialCode: '+33',
        flagEmoji: '🇫🇷',
      );
      const c = Country(
        name: 'Germany',
        code: 'DE',
        dialCode: '+49',
        flagEmoji: '🇩🇪',
      );

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
      expect(a.hashCode, equals(b.hashCode));
    });

    test('toString returns readable format', () {
      const country = Country(
        name: 'Japan',
        code: 'JP',
        dialCode: '+81',
        flagEmoji: '🇯🇵',
      );
      expect(
        country.toString(),
        'Country(name: Japan, code: JP, dialCode: +81, flagEmoji: 🇯🇵)',
      );
    });

    test('fromJson creates country from map', () {
      final json = {
        'name': 'Brazil',
        'code': 'BR',
        'dialCode': '+55',
        'flagEmoji': '🇧🇷',
      };
      final country = Country.fromJson(json);
      expect(country.name, 'Brazil');
      expect(country.code, 'BR');
      expect(country.dialCode, '+55');
      expect(country.flagEmoji, '🇧🇷');
    });

    test('toJson returns correct map', () {
      const country = Country(
        name: 'Italy',
        code: 'IT',
        dialCode: '+39',
        flagEmoji: '🇮🇹',
      );
      final json = country.toJson();
      expect(json['name'], 'Italy');
      expect(json['code'], 'IT');
      expect(json['dialCode'], '+39');
      expect(json['flagEmoji'], '🇮🇹');
    });

    test('fromJson / toJson roundtrip preserves data', () {
      const original = Country(
        name: 'Canada',
        code: 'CA',
        dialCode: '+1',
        flagEmoji: '🇨🇦',
      );
      final roundtrip = Country.fromJson(original.toJson());
      expect(roundtrip, equals(original));
    });
  });

  // ─── CountryData ────────────────────────────────────────────────────

  group('CountryData', () {
    test('countries list is not empty', () {
      expect(CountryData.countries.isNotEmpty, true);
    });

    test('every country has non-empty required fields', () {
      for (final country in CountryData.countries) {
        expect(country.name.isNotEmpty, true,
            reason: 'Country name must not be empty: $country');
        expect(country.code.isNotEmpty, true,
            reason: 'Country code must not be empty: $country');
        expect(country.dialCode.isNotEmpty, true,
            reason: 'Country dialCode must not be empty: $country');
        expect(country.flagEmoji.isNotEmpty, true,
            reason: 'Country flagEmoji must not be empty: $country');
      }
    });

    test('all country codes are exactly 2 characters', () {
      for (final country in CountryData.countries) {
        expect(country.code.length, 2,
            reason: '${country.name} code should be 2 chars, got "${country.code}"');
      }
    });

    test('all dial codes start with +', () {
      for (final country in CountryData.countries) {
        expect(country.dialCode.startsWith('+'), true,
            reason:
                '${country.name} dialCode should start with +, got "${country.dialCode}"');
      }
    });

    test('country codes are unique', () {
      final codes = CountryData.countries.map((c) => c.code).toList();
      expect(codes.length, equals(codes.toSet().length),
          reason: 'Duplicate country codes found');
    });

    test('contains well-known countries', () {
      final codes = CountryData.countries.map((c) => c.code).toSet();
      expect(codes.contains('US'), true);
      expect(codes.contains('GB'), true);
      expect(codes.contains('DE'), true);
      expect(codes.contains('JP'), true);
      expect(codes.contains('CN'), true);
      expect(codes.contains('BR'), true);
      expect(codes.contains('AU'), true);
      expect(codes.contains('IN'), true);
    });
  });

  // ─── CountryParser ──────────────────────────────────────────────────

  group('CountryParser', () {
    test('parseCountryCode returns correct country for uppercase', () {
      final us = CountryParser.parseCountryCode('US');
      expect(us, isNotNull);
      expect(us?.name, 'United States');
      expect(us?.code, 'US');
    });

    test('parseCountryCode returns correct country for lowercase', () {
      final canada = CountryParser.parseCountryCode('ca');
      expect(canada, isNotNull);
      expect(canada?.name, 'Canada');
    });

    test('parseCountryCode returns correct country for mixed case', () {
      final uk = CountryParser.parseCountryCode('Gb');
      expect(uk, isNotNull);
      expect(uk?.name, 'United Kingdom');
    });

    test('parseCountryCode returns null for invalid code', () {
      expect(CountryParser.parseCountryCode('INVALID'), isNull);
      expect(CountryParser.parseCountryCode(''), isNull);
      expect(CountryParser.parseCountryCode('XX'), isNull);
      expect(CountryParser.parseCountryCode('123'), isNull);
    });

    test('parseCountryCode returns all fields populated', () {
      final de = CountryParser.parseCountryCode('DE');
      expect(de, isNotNull);
      expect(de!.name, isNotEmpty);
      expect(de.code, 'DE');
      expect(de.dialCode, '+49');
      expect(de.flagEmoji, isNotEmpty);
    });
  });

  // ─── Widget Tests ───────────────────────────────────────────────────

  group('ClassicCountryDropdown widget', () {
    testWidgets('renders with all defaults', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ClassicCountryDropdown()),
        ),
      );

      // Should show "Select Country" placeholder when no initial country is set
      expect(find.text('Select Country'), findsOneWidget);
      // Should show the dropdown arrow
      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
    });

    testWidgets('renders with initialCountry', (tester) async {
      const initial = Country(
        name: 'Germany',
        code: 'DE',
        dialCode: '+49',
        flagEmoji: '🇩🇪',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ClassicCountryDropdown(
              initialCountry: initial,
              showFlag: true,
              showName: true,
              showDialCode: true,
              showCode: true,
            ),
          ),
        ),
      );

      expect(find.text('Germany'), findsOneWidget);
      expect(find.text('DE'), findsOneWidget);
      expect(find.text('+49'), findsOneWidget);
      expect(find.text('🇩🇪'), findsOneWidget);
    });

    testWidgets('hides flag when showFlag is false', (tester) async {
      const initial = Country(
        name: 'France',
        code: 'FR',
        dialCode: '+33',
        flagEmoji: '🇫🇷',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ClassicCountryDropdown(
              initialCountry: initial,
              showFlag: false,
              showName: true,
            ),
          ),
        ),
      );

      expect(find.text('France'), findsOneWidget);
      expect(find.text('🇫🇷'), findsNothing);
    });

    testWidgets('hides name when showName is false', (tester) async {
      const initial = Country(
        name: 'Italy',
        code: 'IT',
        dialCode: '+39',
        flagEmoji: '🇮🇹',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ClassicCountryDropdown(
              initialCountry: initial,
              showFlag: true,
              showName: false,
            ),
          ),
        ),
      );

      expect(find.text('Italy'), findsNothing);
      expect(find.text('🇮🇹'), findsOneWidget);
    });

    testWidgets('hides dialCode when showDialCode is false (default)',
        (tester) async {
      const initial = Country(
        name: 'Japan',
        code: 'JP',
        dialCode: '+81',
        flagEmoji: '🇯🇵',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ClassicCountryDropdown(
              initialCountry: initial,
              showDialCode: false,
            ),
          ),
        ),
      );

      expect(find.text('+81'), findsNothing);
    });

    testWidgets('shows dialCode when showDialCode is true', (tester) async {
      const initial = Country(
        name: 'Japan',
        code: 'JP',
        dialCode: '+81',
        flagEmoji: '🇯🇵',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ClassicCountryDropdown(
              initialCountry: initial,
              showDialCode: true,
            ),
          ),
        ),
      );

      expect(find.text('+81'), findsOneWidget);
    });

    testWidgets('hides code when showCode is false (default)', (tester) async {
      const initial = Country(
        name: 'Spain',
        code: 'ES',
        dialCode: '+34',
        flagEmoji: '🇪🇸',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ClassicCountryDropdown(
              initialCountry: initial,
              showCode: false,
            ),
          ),
        ),
      );

      expect(find.text('ES'), findsNothing);
    });

    testWidgets('applies custom textStyle', (tester) async {
      const initial = Country(
        name: 'Mexico',
        code: 'MX',
        dialCode: '+52',
        flagEmoji: '🇲🇽',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ClassicCountryDropdown(
              initialCountry: initial,
              showName: true,
              textStyle: TextStyle(fontSize: 24, color: Colors.red),
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Mexico'));
      expect(text.style?.fontSize, 24);
      expect(text.style?.color, Colors.red);
    });

    testWidgets('opens dialog on tap', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ClassicCountryDropdown()),
        ),
      );

      await tester.tap(find.text('Select Country'));
      await tester.pumpAndSettle();

      // The dialog should show the search field
      expect(find.byType(TextField), findsOneWidget);
      // The dialog should show some countries in the list
      expect(find.byType(ListTile), findsWidgets);
    });
  });

  // ─── CountryPickerDialog Widget Tests ───────────────────────────────

  group('CountryPickerDialog widget', () {
    testWidgets('renders with defaults and shows countries', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CountryPickerDialog(),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('search filters countries', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CountryPickerDialog(),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Germany');
      await tester.pumpAndSettle();

      // Should find Germany in the list results (not the search field)
      expect(find.widgetWithText(ListTile, 'Germany'), findsOneWidget);
    });

    testWidgets('custom searchHint is displayed', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CountryPickerDialog(searchHint: 'Find a country...'),
          ),
        ),
      );

      expect(find.text('Find a country...'), findsOneWidget);
    });

    testWidgets('hides flags when showFlag is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CountryPickerDialog(showFlag: false),
          ),
        ),
      );

      // ListTile leading should be null when showFlag is false.
      // We verify by checking no 24px emoji text widgets are rendered.
      final listTiles = tester.widgetList<ListTile>(find.byType(ListTile));
      for (final tile in listTiles) {
        expect(tile.leading, isNull);
      }
    });

    testWidgets('hides dial code when showDialCode is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CountryPickerDialog(showDialCode: false),
          ),
        ),
      );

      final listTiles = tester.widgetList<ListTile>(find.byType(ListTile));
      for (final tile in listTiles) {
        expect(tile.trailing, isNull);
      }
    });

    testWidgets('shows ISO code when showCode is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CountryPickerDialog(showCode: true),
          ),
        ),
      );

      final listTiles = tester.widgetList<ListTile>(find.byType(ListTile));
      for (final tile in listTiles) {
        expect(tile.subtitle, isNotNull);
      }
    });
  });
}
