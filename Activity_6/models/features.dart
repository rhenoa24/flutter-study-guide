class Features {
  final bool onlineBanking;
  final bool mobileBanking;
  final bool cashIn;
  final bool cashOut;

  const Features({
    required this.onlineBanking,
    required this.mobileBanking,
    required this.cashIn,
    required this.cashOut,
  });

  Features copyWith({
    bool? onlineBanking,
    bool? mobileBanking,
    bool? cashIn,
    bool? cashOut,
  }) {
    return Features(
      onlineBanking: onlineBanking ?? this.onlineBanking,
      mobileBanking: mobileBanking ?? this.mobileBanking,
      cashIn: cashIn ?? this.cashIn,
      cashOut: cashOut ?? this.cashOut,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Features &&
        other.onlineBanking == onlineBanking &&
        other.mobileBanking == mobileBanking &&
        other.cashIn == cashIn &&
        other.cashOut == cashOut;
  }

  @override
  int get hashCode =>
      Object.hash(onlineBanking, mobileBanking, cashIn, cashOut);

  @override
  String toString() {
    return '''
Features(
          onlineBanking: $onlineBanking
          mobileBanking: $mobileBanking
          cashIn: $cashIn
          cashOut: $cashOut)''';
  }
}
