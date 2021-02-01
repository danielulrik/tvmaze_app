import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:tvmaze_app/dtos/tv_show_dto.dart';
import 'package:tvmaze_app/util/colors_util.dart';
import 'package:tvmaze_app/util/global.dart';
import 'package:tvmaze_app/util/local_storage_util.dart';

class TvShowWidget extends StatefulWidget {
  final bool detailView;
  final TvShowDto tvShow;
  Function(TvShowDto) onTap;

  TvShowWidget({this.detailView = false, @required this.tvShow, this.onTap});

  @override
  _TvShowWidgetState createState() => _TvShowWidgetState();
}

class _TvShowWidgetState extends State<TvShowWidget> {

  bool _isFavorite = false;

  @override
  void initState() {
    if (widget.detailView) {
      localStorageUtil.isFavorite(widget.tvShow.id).then((isFavorite) {
        setState(() => _isFavorite = isFavorite);
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var show = widget.tvShow;

    return Container(
      margin: EdgeInsets.only(bottom: 4),
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: InkWell(
        onTap: () {
          this.widget.onTap?.call(this.widget.tvShow);
        },
        child:
            widget.detailView ? _buildDetailView(show) : _buildListView(show),
      ),
    );
  }

  _buildListView(TvShowDto show) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(tag: show.heroKey, child: _loadPoster(show)),
        SizedBox(
          width: 8,
        ),
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              show.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              show.genres.join(", "),
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              show.schedule.days.join(", "),
              style: TextStyle(fontSize: 16),
            ),
            Text(
              show.schedule.time,
              style: TextStyle(fontSize: 16),
            ),
          ],
        )),
      ],
    );
  }

  _buildDetailView(TvShowDto show) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 2,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(tag: show.heroKey, child: _loadPoster(show)),
            SizedBox(
              width: 4,
            ),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  show.schedule.days.join(", "),
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  show.schedule.time,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  show.genres.join("\n"),
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 12,
                ),
                Center(
                  child: _buildFavorite(show.id),
                )
              ],
            ))
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Html(
              data: show.summary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFavorite(int showId) {
    if (_isFavorite) {
      return ContainerPlus(
        onTap: () {
          favoritesController.remove(widget.tvShow, (removed) {
            setState(() {
              _isFavorite = removed;
            });
          });
        },
        height: 30,
        width: 160,
        margin: EdgeInsets.all(4),
        radius: RadiusPlus.all(16),
        color: ColorsUtil.green,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'Added as a favorite',
              style: TextStyle(
                  fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ],
        ),
      );
    }

    return ContainerPlus(
      onTap: () {
        favoritesController.add(widget.tvShow, (added) {
          setState(() {
            _isFavorite = added;
          });
        });
      },
      height: 30,
      width: 160,
      margin: EdgeInsets.all(4),
      radius: RadiusPlus.all(16),
      color: ColorsUtil.green,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            'Add as a favorite',
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ],
      ),
    );
  }

  _loadPoster(TvShowDto show) {
    if (show.image == null) return _firstLetter(show);

    var image =
        show.image.original == null ? show.image.original : show.image.medium;

    return ExtendedImage.network(
      image,
      cache: true,
      fit: BoxFit.fitHeight,
      width: widget.detailView ? 200 : 130,
    );
  }

  _firstLetter(TvShowDto show) {
    return Container(
      width: widget.detailView ? 220 : 130,
      height: widget.detailView ? 150 : 100,
      child: Center(
        child: Text(
          show.name.characters.first.toUpperCase(),
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
