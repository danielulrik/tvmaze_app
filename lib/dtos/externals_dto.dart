
class ExternalsDto {
  ExternalsDto({
    this.tvrage,
    this.thetvdb,
    this.imdb,
  });

  int tvrage;
  int thetvdb;
  String imdb;

  factory ExternalsDto.fromJson(Map<String, dynamic> json) => ExternalsDto(
    tvrage: json["tvrage"],
    thetvdb: json["thetvdb"] == null ? null : json["thetvdb"],
    imdb: json["imdb"] == null ? null : json["imdb"],
  );

  Map<String, dynamic> toJson() => {
    "tvrage": tvrage,
    "thetvdb": thetvdb == null ? null : thetvdb,
    "imdb": imdb == null ? null : imdb,
  };
}