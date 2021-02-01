class RatingDto {
  RatingDto({
    this.average,
  });

  num average;

  factory RatingDto.fromJson(Map<String, dynamic> json) => RatingDto(
    average: json["average"] == null ? null : json["average"],
  );

  Map<String, dynamic> toJson() => {
    "average": average == null ? null : average,
  };

}