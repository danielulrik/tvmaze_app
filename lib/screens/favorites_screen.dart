import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:tvmaze_app/screens/tv_show_screen.dart';
import 'package:tvmaze_app/util/colors_util.dart';
import 'package:tvmaze_app/util/global.dart';
import 'package:tvmaze_app/widgets/tv_show_widget.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsUtil.green,
        centerTitle: false,
        title: Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Observer(builder: (_) {
        return ContainerPlus(
          padding: EdgeInsets.all(4),
          child: _buildBody(),
        );
      },),
    );
  }

  _buildBody() {
    return ListView.builder(
          shrinkWrap: true,
          itemCount: favoritesController.favorites.length,
          itemBuilder: (_, int index) {
            return TvShowWidget(tvShow: favoritesController.favorites[index], onTap: (show) {
              navigatorPlus.showModal(TvShowScreen(tvShow: show));
            },);
          });
  }
  
}
