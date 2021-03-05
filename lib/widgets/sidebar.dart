import 'package:flutter/material.dart';

import '../configurations/configurations.dart';

class SideBar extends StatelessWidget {
  Widget buildSidebarMenu(String title, IconData? icon, Function? fun) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: fun as void Function()?);
  }

  final List sidebarItems = Configurations().sideBarItems.length > 0
      ? Configurations().sideBarItems
      : [];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(Configurations().appTitle),
            centerTitle: true,
            leading: new Container(),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (Route<dynamic> route) => false);
              }),
          ...sidebarItems
              .map((item) => buildSidebarMenu(item.title, item.icon, item.fun))
              .toList()
        ],
      ),
    );
  }
}
