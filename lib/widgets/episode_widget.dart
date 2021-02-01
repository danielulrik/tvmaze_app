
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:tvmaze_app/dtos/episode_dto.dart';
import 'package:tvmaze_app/screens/episode_screen.dart';
import 'package:tvmaze_app/util/colors_util.dart';

class EpisodeWidget extends StatefulWidget {

  final bool detailView;
  final EpisodeDto episodeDto;
  final Function(EpisodeDto) onTap;

  EpisodeWidget(this.episodeDto, {this.detailView = false, this.onTap});

  @override
  _EpisodeWidgetState createState() => _EpisodeWidgetState();
}

class _EpisodeWidgetState extends State<EpisodeWidget> {

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
        onTap: () {
          widget.onTap?.call(widget.episodeDto);
        },
        child: Column(children: [
          _buildBody(),
          widget.detailView ? SizedBox.shrink() : SizedBox(height: 4,)
        ]));
  }

  _buildBody() {
    if (widget.detailView) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Hero(tag: widget.episodeDto.heroKey, child: _loadPoster(widget.episodeDto)),
        SizedBox(
          height: 8,
        ),
        widget.detailView ? _buildEpisodeDetailInfo(widget.episodeDto) : _buildEpisodeListInfo(widget.episodeDto)
      ]);
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Hero(tag: widget.episodeDto.heroKey, child: _loadPoster(widget.episodeDto)),
      SizedBox(
        height: 8,
      ),
      widget.detailView ? _buildEpisodeDetailInfo(widget.episodeDto) : _buildEpisodeListInfo(widget.episodeDto)
    ]);
  }

  _buildEpisodeDetailInfo(EpisodeDto episodeDto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '  ${episodeDto.name}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        ContainerPlus(
          child: Html(
            data: _buildSummary(episodeDto),
          ),
        )
      ],
    );
  }

  _buildEpisodeListInfo(EpisodeDto episodeDto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '  Episode ${episodeDto.number}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        ContainerPlus(
          width: 220,
          child: Html(
            data: _buildSummary(episodeDto),
          ),
        )
      ],
    );
  }

  String _buildSummary(EpisodeDto episodeDto) {
    if (episodeDto.summary == null) return "";

    if (episodeDto.summary.length > 199 && !widget.detailView) {
      return episodeDto.summary.substring(0, 100) + '...';
    }
    return episodeDto.summary;
  }

  _loadPoster(EpisodeDto show) {
    if (show.image == null) return _firstLetter(show);

    var image =
    show.image.original == null ? show.image.original : show.image.medium;

    return widget.detailView ? Center(child: _buildImage(image),) :  _buildImage(image);
  }

  _buildImage(String image) {
    return ExtendedImage.network(
    image,
    cache: true,
    fit: BoxFit.fitHeight,
    width: widget.detailView ? 250 : 160,
    height: widget.detailView ? 250 : 160,
  );
  }

  _firstLetter(EpisodeDto episodeDto) {
    return Container(
      width: 160,
      height: 160,
      child: Center(
        child: Text(
          episodeDto.name.characters.first.toUpperCase(),
          maxLines: 3,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.normal,
            color: ColorsUtil.clearestGreen.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

}
