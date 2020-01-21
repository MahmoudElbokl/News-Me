import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_me/Models/NavMenuItem.dart';
import 'package:news_me/Models/theme_changer_provider.dart';
import 'package:news_me/Screens/home_Screen.dart';
import 'package:news_me/Screens/edit_my_news.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  List<NavMenuItem> navMenu = [
    NavMenuItem("Explore", HomeScreen.routeName),
    NavMenuItem("Edit My News", EditMyNews.routeName),
  ];
  bool darkModeValue;

  @override
  void initState() {
    super.initState();
    darkModeValue =
        Provider.of<ThemeModel>(context, listen: false).currentTheme ==
                lightTheme
            ? false
            : true;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Provider
            .of<ThemeModel>(context)
            .currentTheme == lightTheme
            ? Colors.red[100]
            : Colors.grey[850],
        padding: EdgeInsets.only(
            top: (MediaQuery
                .of(context)
                .orientation == Orientation.landscape
                ? 10
                : 50)),
        child: Column(
          children: <Widget>[
            Container(
              height:
              MediaQuery
                  .of(context)
                  .orientation == Orientation.landscape
                  ? MediaQuery
                  .of(context)
                  .size
                  .height * 0.3
                  : MediaQuery
                  .of(context)
                  .size
                  .height * 0.2,
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
                          onTap: () async {
                            await Provider.of<ThemeModel>(context,
                                listen: false)
                                .toggleTheme();
                            SharedPreferences _pre =
                            await SharedPreferences.getInstance();
                            _pre.setBool("darktheme", !darkModeValue);
                            darkModeValue = !darkModeValue;
                            Navigator.pop(context);
                          },
                          title: Text(
                            "Dark Theme",
                            style: Theme.of(context).textTheme.title,
                          ),
                          trailing: Switch(
                              activeColor: Colors.red[400],
                              value: darkModeValue,
                              onChanged: (newValue) async {
                                Provider.of<ThemeModel>(context, listen: false)
                                    .toggleTheme();
                                darkModeValue = newValue;
                                SharedPreferences _pre =
                                await SharedPreferences.getInstance();
                                _pre.setBool("darktheme", newValue);
                                Navigator.pop(context);
                              }),
                        ),
                        Divider(
                          thickness: 3,
                        ),
                      ],
                    );
                  }
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      if (index == 0) {
                        Navigator.pushReplacementNamed(
                            context, navMenu[index - 1].destination);
                      } else {
                        Navigator.pushNamed(
                            context, navMenu[index - 1].destination);
                      }
                    },
                    title: Text(
                      navMenu[index - 1].title,
                      style: Theme.of(context).textTheme.title,
                    ),
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
