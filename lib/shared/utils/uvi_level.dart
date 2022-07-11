class UviLevel {
  String getIndexName(double uvi) {
    if (uvi < 3) return 'Low';
    if (uvi >= 3 && uvi < 6) return 'Medium';
    if (uvi >= 6 && uvi < 8) return 'Very High';
    if (uvi >= 8 && uvi < 11) return 'Very high';
    if (uvi >= 11) return 'Extreme';
    return '???';
  }
}
