import 'package:flutter/material.dart';

import 'package:news_me/Shared_ui/navigation_drawer.dart';

class MainScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget actions;
  final PreferredSizeWidget tabBar;
  final bool navigationDrawer;

  MainScaffold(
      {this.title,
      this.body,
      this.actions,
      this.tabBar,
      this.navigationDrawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
        tabBar == null ? Size.fromHeight(50) : Size.fromHeight(100),
        child: AppBar(
          bottom: tabBar == null ? null : tabBar,
          title: Text(title),
          centerTitle: true,
          actions: <Widget>[
            actions == null ? SizedBox.shrink() : actions,
          ],
        ),
      ),
      drawer: navigationDrawer == true ? NavigationDrawer() : null,
      body: body,
    );
  }
}
