
class ScheduleDto {
  ScheduleDto({
    this.time,
    this.days,
  });

  String time;
  List<String> days;

  factory ScheduleDto.fromJson(Map<String, dynamic> json) => ScheduleDto(
    time: json["time"],
    days: List<String>.from(json["days"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "days": List<dynamic>.from(days.map((x) => x)),
  };
}