import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_me/Shared_ui/navigation_drawer.dart';

class MainScaffold extends StatefulWidget {
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
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  bool isOffline = false;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((event) {
      print("1445");
        if (event == ConnectivityResult.none) {
          print("152000");
          setState(() {
            isOffline = true;
          });
        }else{
          setState(() {
            isOffline = false;
          });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final statusBar = MediaQuery
        .of(context)
        .padding
        .top;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            widget.tabBar == null ? Size.fromHeight(50) : Size.fromHeight(100),
        child: AppBar(
          bottom: widget.tabBar == null ? null : widget.tabBar,
          title: Text(
            widget.title,
            style: GoogleFonts.ibarraRealNova(
                fontSize: height > 700 ? 21 : 17, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          actions: <Widget>[
            widget.actions == null ? SizedBox.shrink() : widget.actions,
          ],
        ),
      ),
      drawer: widget.navigationDrawer == true ? NavigationDrawer() : null,
      body: isOffline ? Padding(
        padding: EdgeInsets.only(
            left: 15,
            right: 15,
            top: (height * 0.5 - 100 - statusBar)),
        child: Text(
          "You have a network connection error, Please check your connection",
          textAlign: TextAlign.center,
        ),
      ) :widget.body,
    );
  }
}
