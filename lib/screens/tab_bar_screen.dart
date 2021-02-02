import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:tvmaze_app/screens/favorites_screen.dart';
import 'package:tvmaze_app/screens/tv_shows_screen.dart';
import 'package:tvmaze_app/util/colors_util.dart';

import 'tab_bar_controller.dart';

class TabBarScreen extends StatefulWidget {
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  final _tabController = GetIt.I<TabBarController>();

  final List<Widget> _children = [
    TvShowsScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        this._tabController.backTabIndex();
      },
      child: Observer(
        builder: (_) {
          return Scaffold(
            backgroundColor: ColorsUtil.background,
            body: IndexedStack(
              index: _tabController.tabIndex,
              children: this._children,
            ),
            bottomNavigationBar:
            _buildBottomBar(context, _tabController.tabIndex),
          );
        },
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: [
        this._buildNavigationItem(
          title: 'TV Shows',
          img: Icons.live_tv,
        ),
        this._buildNavigationItem(
          title: 'Favorites',
          img: Icons.favorite,
        ),
      ],
      currentIndex: currentIndex,
      elevation: 10,
      selectedItemColor: ColorsUtil.green,
      onTap: (int index) {
        HapticFeedback.selectionClick();
        this._tabController.changeTabIndex(index);
      },
    );
  }

  _buildNavigationItem({String title, IconData img}) {
    return BottomNavigationBarItem(
      icon: Icon(img, color: ColorsUtil.blueGray,),
      activeIcon: Icon(img, color: ColorsUtil.green,),
      title: Container(
        margin: EdgeInsets.only(top: 4),
        child: Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
