import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_me/Models/NavMenuItem.dart';
import 'package:news_me/controllers/theme_changer_provider.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  List<NavMenuItem> navMenu = [
    NavMenuItem("Explore", "/homeScreen"),
  ];
  bool darkModeValue;

  @override
  void initState() {
    super.initState();
    darkModeValue =
        Provider.of<ThemeModel>(context, listen: false).currentTheme ==
            lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Drawer(
      child: Container(
        color: Provider.of<ThemeModel>(context).currentTheme == lightTheme
            ? Colors.red[100]
            : Colors.grey[850],
        padding: EdgeInsets.only(
            top: (mediaQuery.orientation == Orientation.landscape ? 10 : 50)),
        child: Column(
          children: <Widget>[
            Container(
              height: mediaQuery.orientation == Orientation.landscape
                  ? mediaQuery.size.height * 0.3
                  : mediaQuery.size.height * 0.2,
              child: Image.asset("assets/images/NewsMe.png"),
            ),
            Expanded(
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
                          },
                          trailing: Switch(
                              activeColor: Colors.red[400],
                              value: darkModeValue,
                              onChanged: (newValue) async {
                                Provider.of<ThemeModel>(context, listen: false)
                                    .toggleTheme();
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
