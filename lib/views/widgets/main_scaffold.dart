import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_me/controllers/theme_changer_provider.dart';
import 'package:news_me/views/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class MainScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final Widget actions;
  final bool navigationDrawer;

  MainScaffold({this.title, this.body, this.actions, this.navigationDrawer});

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold>
    with SingleTickerProviderStateMixin {
  bool darkModeValue;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  void toggle() {
    _animationController.isDismissed
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final maxSlide = MediaQuery.of(context).size.width * 0.6;
    darkModeValue = Provider.of<ThemeModel>(context).currentTheme == lightTheme;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return Stack(
          children: <Widget>[
            widget.navigationDrawer == true
                ? MainDrawer(darkModeValue, toggle)
                : Container(),
            Transform(
              transform: Matrix4.identity()
                ..translate(_animationController.value * maxSlide)
                ..scale(
                  1 - (_animationController.value * 0.3),
                ),
              alignment: Alignment.centerLeft,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    widget.title,
                    style: GoogleFonts.ibarraRealNova(
                        fontSize: height > 700 ? 21 : 17,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: widget.navigationDrawer == true
                      ? IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            toggle();
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                  centerTitle: true,
                  actions: <Widget>[
                    widget.actions == null ? SizedBox.shrink() : widget.actions,
                  ],
                ),
                body: Provider.of<bool>(context)
                    ? Center(
                        child: Text(
                          "You have a network connection error, Please check your connection",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : widget.body,
              ),
            ),
          ],
        );
      },
    );
  }
}
