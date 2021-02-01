
import 'country_dto.dart';

class NetworkDto {
  NetworkDto({
    this.id,
    this.name,
    this.country,
  });

  int id;
  String name;
  CountryDto country;

  factory NetworkDto.fromJson(Map<String, dynamic> json) => NetworkDto(
    id: json["id"],
    name: json["name"],
    country: json["country"] == null ? null : CountryDto.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country": country == null ? null : country.toJson(),
  };
}