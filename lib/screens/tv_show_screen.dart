import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:tvmaze_app/controllers/tv_show_controller.dart';
import 'package:tvmaze_app/dtos/season_dto.dart';
import 'package:tvmaze_app/dtos/tv_show_dto.dart';
import 'package:tvmaze_app/screens/episodes_screen.dart';
import 'package:tvmaze_app/util/colors_util.dart';
import 'package:tvmaze_app/widgets/skeleton_list_widget.dart';
import 'package:tvmaze_app/widgets/tv_show_widget.dart';
import 'package:intl/intl.dart';

class TvShowScreen extends StatefulWidget {
  final TvShowDto tvShow;

  TvShowScreen({this.tvShow});

  @override
  _TvShowScreenState createState() => _TvShowScreenState();
}

class _TvShowScreenState extends State<TvShowScreen> {
  final _controller = TvShowController();

  @override
  void initState() {
    super.initState();
    _controller.getSeasons(widget.tvShow.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.background,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorsUtil.green,
          centerTitle: false,
          title: Text(
            widget.tvShow.name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: <Widget>[]),
      body: Observer(
        builder: (_) {
          return SingleChildScrollView(child: Column(
            children: [
              TvShowWidget(detailView: true, tvShow: widget.tvShow),
              Column(
                children: [
                  Text(
                    'Seasons',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  _buildSeasons()
                ],
              )
            ],
          ),);
        },
      ),
    );
  }

  _buildSeasons() {
    if (!_controller.seasonsRequest.isDone) {
      return SkeletonListWidget(
          qtd: 6, radius: 8, height: 14, margin: EdgeInsets.all(12));
    }
    return Column(children: _controller.seasonsRequest.getData.map((season) => _buildItemSeason(season)).toList(),);
  }

  Widget _buildItemSeason(SeasonDto seasonDto) {
    return ContainerPlus(
      onTap: () {
        navigatorPlus.showModal(EpisodesScreen(seasonDto));
      },
      height: 30,
      width: 300,
      margin: EdgeInsets.all(4),
      radius: RadiusPlus.all(16),
      color: ColorsUtil.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Season ${seasonDto.number}',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
          ),
          Text(
            '${dateToString(seasonDto.premiereDate, format: 'yyyy-MM-dd')} (Airing date)',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
          )
        ],
      ),
    );
  }

  String dateToString(DateTime date, {@required String format}) {
    if (this == null) {
      return '';
    }
    return DateFormat(format).format(date);
  }
}
