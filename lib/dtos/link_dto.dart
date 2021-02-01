
class LinkDto {
  LinkDto({
    this.href,
  });

  String href;

  factory LinkDto.fromJson(Map<String, dynamic> json) => LinkDto(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}