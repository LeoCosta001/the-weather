class PositionstackLocationNormalize {
  double latitude;
  double longitude;
  String type;
  String title;
  String subTitle;

  PositionstackLocationNormalize({
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.title,
    required this.subTitle,
  });

  // Convert JSON to Object
  PositionstackLocationNormalize.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'],
        type = json['type'],
        title = json['title'],
        subTitle = json['subTitle'];

  // Convert Object to JSON
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'type': type,
        'title': title,
        'subTitle': subTitle,
      };
}
