import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:tvmaze_app/controllers/episodes_controller.dart';
import 'package:tvmaze_app/dtos/season_dto.dart';
import 'package:tvmaze_app/screens/episode_screen.dart';
import 'package:tvmaze_app/util/colors_util.dart';
import 'package:tvmaze_app/widgets/episode_widget.dart';
import 'package:tvmaze_app/widgets/skeleton_list_widget.dart';

class EpisodesScreen extends StatefulWidget {
  final SeasonDto seasonDto;

  EpisodesScreen(this.seasonDto);

  @override
  _EpisodesScreenState createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  final _controller = EpisodesController();

  @override
  void initState() {
    super.initState();
    _controller.getEpisodes(widget.seasonDto.id);
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
          'Season ${widget.seasonDto.number} - Episodes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Observer(
        builder: (_) {
          return _buildEpisodes();
        },
      ),
    );
  }

  _buildEpisodes() {
    if (!_controller.episodesRequest.isDone) {
      return SkeletonListWidget(
          qtd: 5, radius: 8, height: 150, margin: EdgeInsets.all(12));
    }
    return ContainerPlus(
      padding: EdgeInsets.all(4),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _controller.episodesRequest.getData == null ? 0 : _controller.episodesRequest.getData.length,
          itemBuilder: (_, int index) {
            if (_controller.episodesRequest.getData == null || _controller.episodesRequest.getData.isEmpty) return SizedBox.shrink();
            return EpisodeWidget(
              _controller.episodesRequest.getData[index],
              onTap: (e) {
                navigatorPlus.showModal(EpisodeScreen(e));
              },
            );
          }),
    );
  }
}
