import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:tvmaze_app/controllers/tv_shows_controller.dart';
import 'package:tvmaze_app/screens/favorites_screen.dart';
import 'package:tvmaze_app/screens/tv_show_screen.dart';
import 'package:tvmaze_app/util/colors_util.dart';
import 'package:tvmaze_app/util/global.dart';
import 'package:tvmaze_app/widgets/infinite_list_widget.dart';
import 'package:tvmaze_app/widgets/skeleton_list_widget.dart';
import 'package:tvmaze_app/widgets/tv_show_widget.dart';

class TvShowsScreen extends StatefulWidget {
  @override
  _TvShowsScreenState createState() => _TvShowsScreenState();
}

class _TvShowsScreenState extends State<TvShowsScreen> with WidgetsBindingObserver {

  final _controller = TvShowsController();
  final _textEditingControllerSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.getShows();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(64.0),
      child: Observer(builder: (_) {
        return AppBar(
          elevation: 0,
          backgroundColor: ColorsUtil.green,
          centerTitle: false,
          // titleSpacing: 16,
          title: this._buildContainerSearch(context),
          // actions: _buildActions(),
        );
      },),
    );
  }

  List<Widget> _buildActions() {
    if (favoritesController.favorites.isEmpty) return [];
    return [
        IconButton(icon: Icon(Icons.favorite, color: ColorsUtil.white,), onPressed: () {
          navigatorPlus.showModal(FavoritesScreen());
        })
      ];
  }

  _buildBody(BuildContext context) {
    if (_controller.showsRequest.isPending) {
      return SkeletonListWidget(
          qtd: 10, radius: 8, height: 100, margin: EdgeInsets.all(12));
    }
    var list = _controller.showsRequest.getData;

    return InfiniteListWidget(
      margin: EdgeInsets.only(left: 1, top: 4),
      noResultString: 'No tv shows were found.',
      hasNext: _textEditingControllerSearch.text.isEmpty && _controller.showsRequest.hasNextPage,
      nextData: () {
        return _controller.getShows();
      },
      itemCount: list.length,
      itemBuilder: (_, int index) {
        return TvShowWidget(
          tvShow: list[index],
          onTap: (show) {
            navigatorPlus.showModal(TvShowScreen(tvShow: show));
          },
        );
      },
    );
  }

  _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.background,
      appBar: this._buildAppBar(context),
      body: Observer(
        builder: (_) {
          return this._buildBody(context);
        },
      ),
    );
  }

  _buildContainerSearch(BuildContext context) {
    return TextFieldPlus(
      radius: RadiusPlus.all(4),
      maxLines: 1,
      backgroundColor: ColorsUtil.background,
      placeholder: TextPlus(
        'Search TV Shows',
        color: ColorsUtil.blueGray,
      ),
      fontSize: 16,
      fontWeight: FontWeight.normal,
      textInputAction: TextInputAction.search,
      onSubmitted: (search) {
        if (search.length >= 3) {
          _controller.getShowsByQuery(search);
        } else if (search.isEmpty) {
          _controller.getShows(page: 0);
        }
      },
      textCapitalization: TextCapitalization.words,
      prefixWidget: Icon(
        Icons.search,
        color: ColorsUtil.clearGreen,
      ),
      controller: this._textEditingControllerSearch,
      // onChanged: (search) {
      //   if (search.length >= 3) {
      //     _controller.debouncedSearch(search);
      //   } else if (search.isEmpty) {
      //     _controller.getShows(page: 0);
      //   }
      // }

    );
  }
}
