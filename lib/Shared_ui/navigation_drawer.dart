import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_me/Models/NavMenuItem.dart';
import 'package:news_me/Models/theme_changer_provider.dart';
import 'package:news_me/Screens/home_Screen.dart';
import 'package:news_me/Screens/edit_my_news.dart';

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
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset("assets/images/NewsMe.png"),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: <Widget>[
                        Divider(
                          thickness: 3,
                        ),
                        ListTile(
                          onTap: () {
                            Provider.of<ThemeModel>(context, listen: false)
                                .toggleTheme();
                            darkModeValue = true;
                            Navigator.pop(context);
                          },
                          title: Text(
                            "Dark Theme",
                            style: Theme.of(context).textTheme.title,
                          ),
                          trailing: Switch(
                              activeColor: Colors.red,
                              value: darkModeValue,
                              onChanged: (newValue) async {
                                await Provider.of<ThemeModel>(context,
                                        listen: false)
                                    .toggleTheme();
                                darkModeValue = true;
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
