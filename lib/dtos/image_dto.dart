class ImageDto {
  ImageDto({
    this.medium,
    this.original,
  });

  String medium;
  String original;

  factory ImageDto.fromJson(Map<String, dynamic> json) => ImageDto(
    medium: json["medium"],
    original: json["original"],
  );

  Map<String, dynamic> toJson() => {
    "medium": medium,
    "original": original,
  };
}