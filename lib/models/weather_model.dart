class WeatherModel {
  final String cityName;
  final double temp;
  final double minTemp;
  final double maxTemp;
  final String condition;
  final String date;
  final String? image;

  WeatherModel({
    required this.minTemp,
    required this.maxTemp,
    required this.condition,
    required this.date,
    required this.cityName,
    required this.temp,
    this.image,
  });
  factory WeatherModel.fromJson(json) {
    return WeatherModel(
      cityName: json['location']['name'],
      temp: json["forecast"]['forecastday'][0]['day']['avgtemp_c'],
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
      maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      condition:json['forecast']['forecastday'][0]['day']['condition'] ['text'],
      date: json['current']['last_updated'],
      image:json['forecast']['forecastday'][0]['day']['condition']['icon'],
    );
  }
}
