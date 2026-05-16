class Country {
  /// The name of the country.
  final String name;

  /// The two-letter ISO 3166-1 alpha-2 country code.
  final String code;

  /// The international dial code for the country.
  final String dialCode;

  /// The emoji flag for the country.
  final String flagEmoji;

  /// Alias for [code] to maintain compatibility with other packages.
  String get countryCode => code;

  /// Creates a new [Country] instance.
  const Country({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flagEmoji,
  });

  /// Creates a [Country] from a JSON map.
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] as String,
      code: json['code'] as String,
      dialCode: json['dialCode'] as String,
      flagEmoji: json['flagEmoji'] as String,
    );
  }

  /// Converts the [Country] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'dialCode': dialCode,
      'flagEmoji': flagEmoji,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.name == name &&
        other.code == code &&
        other.dialCode == dialCode &&
        other.flagEmoji == flagEmoji;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        code.hashCode ^
        dialCode.hashCode ^
        flagEmoji.hashCode;
  }

  @override
  String toString() {
    return 'Country(name: $name, code: $code, dialCode: $dialCode, flagEmoji: $flagEmoji)';
  }
}
