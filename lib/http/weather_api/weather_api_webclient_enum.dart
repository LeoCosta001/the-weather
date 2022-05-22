// More info about this queryString options "https://openweathermap.org/api/one-call-api#other"

/* List of query string config */

enum WeatherApiOneCallExcludeEnum {
  current('current'),
  minutely('minutely'),
  hourly('hourly'),
  daily('daily'),
  alerts('alerts');

  final String value;

  const WeatherApiOneCallExcludeEnum(this.value);
}

enum WeatherApiOneCallUnitsEnum {
  // Get data like [Temperature = "Fahrenheit"] [Wind speed & Wind gust = "meter/sec"]
  standard('standard'),
  // Get data like [Temperature = "Kelvin"] [Wind speed & Wind gust = "meter/sec"]
  metric('metric'),
  // Get data like [Temperature = "Celsius"] [Wind speed & Wind gust = "miles/hour"]
  imperial('imperial');

  final String value;

  const WeatherApiOneCallUnitsEnum(this.value);
}

enum WeatherApiOneCallLangEnum {
  af('af'), // Afrikaans
  al('al'), // Albanian
  ar('ar'), // Arabic
  az('az'), // Azerbaijani
  bg('bg'), // Bulgarian
  ca('ca'), // Catalan
  cz('cz'), // Czech
  da('da'), // Danish
  de('de'), // German
  el('el'), // Greek
  en('en'), // English
  eu('eu'), // Basque
  fa('fa'), // Persian (Farsi)
  fi('fi'), // Finnish
  fr('fr'), // French
  gl('gl'), // Galician
  he('he'), // Hebrew
  hi('hi'), // Hindi
  hr('hr'), // Croatian
  hu('hu'), // Hungarian
  id('id'), // Indonesian
  it('it'), // Italian
  ja('ja'), // Japanese
  kr('kr'), // Korean
  la('la'), // Latvian
  lt('lt'), // Lithuanian
  mk('mk'), // Macedonian
  no('no'), // Norwegian
  nl('nl'), // Dutch
  pl('pl'), // Polish
  pt('pt'), // Portuguese
  pt_br('pt_br'), // Português Brasil
  ro('ro'), // Romanian
  ru('ru'), // Russian
  sv('sv'), // Swedish
  se('se'), // Swedish
  sk('sk'), // Slovak
  sl('sl'), // Slovenian
  sp('sp'), // Spanish
  es('es'), // Spanish
  sr('sr'), // Serbian
  th('th'), // Thai
  tr('tr'), // Turkish
  ua('ua'), // Ukrainian
  uk('uk'), // Ukrainian
  vi('vi'), //  Vietnamese
  zh_cn('zh_cn'), // Chinese Simplified
  zh_tw('zh_tw'), // Chinese Traditional
  zu('zu'); // Zulu

  final String value;

  const WeatherApiOneCallLangEnum(this.value);
}
