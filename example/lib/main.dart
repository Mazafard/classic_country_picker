import 'package:flutter/material.dart';
import 'package:classic_country_picker/classic_country_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classic Country Picker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  Country? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classic Country Picker'),
        elevation: 2,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Select your country:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Center(
                child: ClassicCountryDropdown(
                  showFlag: true,
                  showDialCode: true,
                  showName: true,
                  showCode: false,
                  initialCountry:
                      CountryData.countries.firstWhere((c) => c.code == 'US'),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueAccent),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  onChanged: (Country country) {
                    setState(() {
                      _selectedCountry = country;
                    });
                  },
                ),
              ),
              const SizedBox(height: 32),
              if (_selectedCountry != null) ...[
                const Text(
                  'Selected Country Details:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text('Name: ${_selectedCountry!.name}',
                    textAlign: TextAlign.center),
                Text('Code: ${_selectedCountry!.code}',
                    textAlign: TextAlign.center),
                Text('Dial Code: ${_selectedCountry!.dialCode}',
                    textAlign: TextAlign.center),
                Text('Flag: ${_selectedCountry!.flagEmoji}',
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
