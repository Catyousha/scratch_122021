import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'weather.g.dart';

enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}


@JsonSerializable()
class Weather extends Equatable {
  const Weather({
    required this.location,
    required this.condition,
    required this.temperature,
  });

  final String location;
  final double temperature;
  final WeatherCondition condition;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  @override
  List<Object> get props => [location, temperature, condition];
}
