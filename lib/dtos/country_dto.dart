
class CountryDto {
  CountryDto({
    this.name,
    this.code,
    this.timezone,
  });

  String name;
  String code;
  String timezone;

  factory CountryDto.fromJson(Map<String, dynamic> json) => CountryDto(
    name: json["name"],
    code: json["code"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "timezone": timezone,
  };
}