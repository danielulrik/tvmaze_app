import 'dart:convert';

import 'package:tvmaze_app/dtos/image_dto.dart';
import 'package:uuid/uuid.dart';

import 'links_dto.dart';

List<EpisodeDto> seasonDtoFromMap(String str) => List<EpisodeDto>.from(json.decode(str).map((x) => EpisodeDto.fromJson(x)));

String seasonDtoToMap(List<EpisodeDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EpisodeDto {

  final String heroKey = Uuid().v4();

  EpisodeDto({
    this.id,
    this.url,
    this.name,
    this.season,
    this.number,
    this.type,
    this.airdate,
    this.airtime,
    this.airstamp,
    this.runtime,
    this.image,
    this.summary,
    this.links,
  });

  int id;
  String url;
  String name;
  int season;
  int number;
  String type;
  DateTime airdate;
  String airtime;
  DateTime airstamp;
  int runtime;
  ImageDto image;
  String summary;
  LinksDto links;

  factory EpisodeDto.fromJson(Map<String, dynamic> json) => EpisodeDto(
    id: json["id"],
    url: json["url"],
    name: json["name"],
    season: json["season"],
    number: json["number"],
    type: json["type"],
    airdate: json["airdate"] != null ? DateTime.parse(json["airdate"]) : null,
    airtime: json["airtime"],
    airstamp: json["airstamp"] != null ? DateTime.parse(json["airstamp"]) : null,
    runtime: json["runtime"],
    image: json["image"] != null ? ImageDto.fromJson(json["image"]) : null,
    summary: json["summary"],
    links: json["_links"] != null ? LinksDto.fromJson(json["_links"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "name": name,
    "season": season,
    "number": number,
    "type": type,
    "airdate": "${airdate.year.toString().padLeft(4, '0')}-${airdate.month.toString().padLeft(2, '0')}-${airdate.day.toString().padLeft(2, '0')}",
    "airtime": airtime,
    "airstamp": airstamp.toIso8601String(),
    "runtime": runtime,
    "image": image?.toJson(),
    "summary": summary,
    "_links": links?.toJson(),
  };
}