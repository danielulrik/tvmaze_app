import 'dart:convert';

import 'package:tvmaze_app/dtos/externals_dto.dart';
import 'package:tvmaze_app/dtos/image_dto.dart';
import 'package:tvmaze_app/dtos/links_dto.dart';
import 'package:tvmaze_app/dtos/network_dto.dart';
import 'package:tvmaze_app/dtos/rating_dto.dart';
import 'package:tvmaze_app/dtos/schedule_dto.dart';
import 'package:tvmaze_app/dtos/web_channel_dto.dart';
import 'package:uuid/uuid.dart';

List<TvShowDto> showDtoFromJson(String str) => List<TvShowDto>.from(json.decode(str).map((x) => TvShowDto.fromJson(x)));

String showDtoToJson(List<TvShowDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TvShowDto {

  final String heroKey = Uuid().v4();

  TvShowDto({
    this.id,
    this.url,
    this.name,
    this.type,
    this.language,
    this.genres,
    this.status,
    this.runtime,
    this.premiered,
    this.officialSite,
    this.schedule,
    this.rating,
    this.weight,
    this.network,
    this.webChannel,
    this.externals,
    this.image,
    this.summary,
    this.updated,
    this.links,
  });

  int id;
  String url;
  String name;
  String type;
  String language;
  List<String> genres;
  String status;
  int runtime;
  DateTime premiered;
  String officialSite;
  ScheduleDto schedule;
  RatingDto rating;
  int weight;
  NetworkDto network;
  WebChannelDto webChannel;
  ExternalsDto externals;
  ImageDto image;
  String summary;
  int updated;
  LinksDto links;

  factory TvShowDto.fromJson(Map<String, dynamic> json) => TvShowDto(
    id: json["id"],
    url: json["url"],
    name: json["name"],
    type: json["type"],
    language: json["language"],
    genres: json["genres"] != null ? List<String>.from(json["genres"].map((x) => x)) : null,
    status: json["status"],
    runtime: json["runtime"],
    premiered: json["premiered"] == null ? null : DateTime.parse(json["premiered"]),
    officialSite: json["officialSite"] == null ? null : json["officialSite"],
    schedule: json["schedule"] != null ? ScheduleDto.fromJson(json["schedule"]) : null,
    rating: json["rating"] != null ? RatingDto.fromJson(json["rating"]) : null,
    weight: json["weight"],
    network: json["network"] == null ? null : NetworkDto.fromJson(json["network"]),
    webChannel: json["webChannel"] == null ? null : WebChannelDto.fromJson(json["webChannel"]),
    externals: ExternalsDto.fromJson(json["externals"]),
    image: json["image"] != null ? ImageDto.fromJson(json["image"]) : null,
    summary: json["summary"],
    updated: json["updated"],
    links: json["_links"] != null ? LinksDto.fromJson(json["_links"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "name": name,
    "type": type,
    "language": language,
    "genres": genres != null ? List<dynamic>.from(genres.map((x) => x)) : null,
    "status": status,
    "runtime": runtime == null ? null : runtime,
    "premiered": premiered == null ? null : "${premiered.year.toString().padLeft(4, '0')}-${premiered.month.toString().padLeft(2, '0')}-${premiered.day.toString().padLeft(2, '0')}",
    "officialSite": officialSite == null ? null : officialSite,
    "schedule": schedule.toJson(),
    "rating": rating.toJson(),
    "weight": weight,
    "network": network == null ? null : network.toJson(),
    "webChannel": webChannel == null ? null : webChannel.toJson(),
    "externals": externals.toJson(),
    "image": image.toJson(),
    "summary": summary,
    "updated": updated,
    "_links": links.toJson(),
  };
}