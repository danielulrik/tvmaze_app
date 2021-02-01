import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:tvmaze_app/dtos/episode_dto.dart';
import 'package:tvmaze_app/util/colors_util.dart';
import 'package:tvmaze_app/widgets/episode_widget.dart';

class EpisodeScreen extends StatefulWidget {
  final EpisodeDto episodeDto;

  EpisodeScreen(this.episodeDto);

  @override
  _EpisodeScreenState createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.background,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorsUtil.green,
          centerTitle: false,
          title: Text(
            'Season ${widget.episodeDto.season} - Episode ${widget.episodeDto.number}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: <Widget>[]),
      body: SingleChildScrollView(child: ContainerPlus(
        margin: EdgeInsets.only(left: 4, top: 4),
        child: EpisodeWidget(
          widget.episodeDto,
          detailView: true,
        ),
      ),),
    );
  }
}
