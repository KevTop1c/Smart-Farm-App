class DHT {
  final double light;
  final double temp;
  final double moisture;
  final double humidity;

  DHT(
      {required this.light,
      required this.temp,
      required this.moisture,
      required this.humidity});

  factory DHT.fromJson(Map<dynamic, dynamic> json) {
    double parser(dynamic source) {
      try {
        return double.parse(source.toString());
      } on FormatException {
        return -1;
      }
    }

    return DHT(
        temp: parser(json['temp']),
        humidity: parser(json['humidity']),
        moisture: parser(json['moist']),
        light: parser(json['Light']));
  }
}
