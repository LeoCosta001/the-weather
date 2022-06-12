// More info about this API response "https://positionstack.com/documentation"

class PositionstackApi {
  late final List<PositionstackApiData> data;

  @override
  // Convert JSON to Object
  PositionstackApi.fromJson(Map<String, dynamic> json)
      : data =
            List<PositionstackApiData>.from(json['data'].map((value) => PositionstackApiData.fromJson(value)).toList());
}

class PositionstackApiData {
  late final double latitude;
  late final double longitude;
  late final String type;
  // late final PositionstackApiDataType type; /// TODO: Set enum in this value
  late final String? county;
  late final String? locality;
  late final String? neighbourhood;
  late final String? region;
  late final String? regionCode;
  late final String? country;
  late final String? countryCode;
  late final String continent;
  late final double confidence; // 0 ~ 1
  late final String label;

  @override
  // Convert JSON to Object
  PositionstackApiData.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'],
        type = json['type'],
        county = json['county'],
        locality = json['locality'],
        neighbourhood = json['neighbourhood'],
        region = json['region'],
        regionCode = json['region_code'],
        country = json['country'],
        countryCode = json['country_code'],
        continent = json['continent'],
        confidence = json['confidence'].toDouble(),
        label = json['label'];
}

enum PositionstackApiDataType {
  venue('venue'),
  address('address'),
  street('street'),
  neighbourhood('neighbourhood'),
  borough('borough'),
  localadmin('localadmin'),
  locality('locality'),
  county('county'),
  macrocounty('macrocounty'),
  region('region'),
  macroregion('macroregion'),
  country('country'),
  coarse('coarse'),
  postalcode('postalcode');

  final String value;

  const PositionstackApiDataType(this.value);
}
