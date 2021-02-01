import 'country_dto.dart';

class WebChannelDto {

  WebChannelDto({
    this.id,
    this.name,
    this.country,
  });

  int id;
  String name;
  CountryDto country;

  factory WebChannelDto.fromJson(Map<String, dynamic> json) => WebChannelDto(
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