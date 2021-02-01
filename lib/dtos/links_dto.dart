
import 'package:tvmaze_app/dtos/link_dto.dart';

class LinksDto {
  LinksDto({
    this.self,
    this.previousepisode,
    this.nextepisode,
  });

  LinkDto self;
  LinkDto previousepisode;
  LinkDto nextepisode;

  factory LinksDto.fromJson(Map<String, dynamic> json) => LinksDto(
    self: LinkDto.fromJson(json["self"]),
    previousepisode: json["previousepisode"] == null ? null : LinkDto.fromJson(json["previousepisode"]),
    nextepisode: json["nextepisode"] == null ? null : LinkDto.fromJson(json["nextepisode"]),
  );

  Map<String, dynamic> toJson() => {
    "self": self.toJson(),
    "previousepisode": previousepisode == null ? null : previousepisode.toJson(),
    "nextepisode": nextepisode == null ? null : nextepisode.toJson(),
  };
}