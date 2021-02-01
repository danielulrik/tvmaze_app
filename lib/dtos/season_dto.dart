import 'dart:convert';

import 'package:tvmaze_app/dtos/image_dto.dart';
import 'package:tvmaze_app/dtos/network_dto.dart';
import 'package:tvmaze_app/dtos/web_channel_dto.dart';

import 'links_dto.dart';

List<SeasonDto> seasonDtoFromMap(String str) => List<SeasonDto>.from(json.decode(str).map((x) => SeasonDto.fromJson(x)));

String seasonDtoToMap(List<SeasonDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SeasonDto {
  SeasonDto({
    this.id,
    this.url,
    this.number,
    this.name,
    this.episodeOrder,
    this.premiereDate,
    this.endDate,
    this.network,
    this.webChannel,
    this.image,
    this.summary,
    this.links,
  });

  int id;
  String url;
  int number;
  String name;
  int episodeOrder;
  DateTime premiereDate;
  DateTime endDate;
  NetworkDto network;
  WebChannelDto webChannel;
  ImageDto image;
  String summary;
  LinksDto links;

  factory SeasonDto.fromJson(Map<String, dynamic> json) => SeasonDto(
    id: json["id"],
    url: json["url"],
    number: json["number"],
    name: json["name"],
    episodeOrder: json["episodeOrder"],
    premiereDate: DateTime.parse(json["premiereDate"]),
    endDate: DateTime.parse(json["endDate"]),
    network: json["network"] != null ? NetworkDto.fromJson(json["network"]) : null,
    webChannel: json["webChannel"] != null ? WebChannelDto.fromJson(json["webChannel"]) : null,
    image: json["image"] != null ? ImageDto.fromJson(json["image"]) : null,
    summary: json["summary"],
    links: json["_links"] != null ? LinksDto.fromJson(json["_links"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "number": number,
    "name": name,
    "episodeOrder": episodeOrder,
    "premiereDate": "${premiereDate.year.toString().padLeft(4, '0')}-${premiereDate.month.toString().padLeft(2, '0')}-${premiereDate.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "network": network.toJson(),
    "webChannel": webChannel,
    "image": image.toJson(),
    "summary": summary,
    "_links": links.toJson(),
  };
}