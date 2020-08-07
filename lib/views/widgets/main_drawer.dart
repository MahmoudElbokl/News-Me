import 'package:flutter/material.dart';
import 'package:news_me/Models/NavMenuItem.dart';
import 'package:news_me/controllers/theme_changer_provider.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  final bool darkModeValue;
  final Function toggle;

  MainDrawer(this.darkModeValue, this.toggle);

  final List<NavMenuItem> navMenu = [
    NavMenuItem("Explore", "/homeScreen"),
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Material(
      child: Container(
        height: mediaQuery.size.height,
        width: mediaQuery.size.width,
        color: Theme.of(context).canvasColor,
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: mediaQuery.size.width * 0.1 - 20),
              height: mediaQuery.orientation == Orientation.landscape
                  ? mediaQuery.size.height * 0.3
                  : mediaQuery.size.height * 0.2,
              child: Image.asset("assets/images/NewsMe.png"),
            ),
            Container(
              height: mediaQuery.size.height * 0.6,
              width: mediaQuery.size.width * 0.6,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: <Widget>[
                        Divider(
                          thickness: 3,
                        ),
                        ListTile(
                          title: Text(
                            "Light Theme",
                          ),
                          onTap: () async {
                            await Provider.of<ThemeModel>(context,
                                    listen: false)
                                .toggleTheme();
                            toggle();
                          },
                          trailing: Switch(
                              activeColor: Colors.red[400],
                              value: darkModeValue,
                              onChanged: (newValue) async {
                                Provider.of<ThemeModel>(context, listen: false)
                                    .toggleTheme();
                                toggle();
                              }),
                        ),
                        Divider(
                          thickness: 3,
                        ),
                      ],
                    );
                  }
                  return ListTile(
                    title: Text(
                      navMenu[index - 1].title,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      if (index == 0) {
                        Navigator.popUntil(
                            context,
                            ModalRoute.withName(
                                navMenu[index - 1].destination));
                      } else {
                        Navigator.pushNamed(
                            context, navMenu[index - 1].destination);
                      }
                    },
                    trailing: Icon(Icons.chevron_right),
                  );
                },
                itemCount: navMenu.length + 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
