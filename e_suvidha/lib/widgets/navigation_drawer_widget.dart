import 'package:e_suvidha/data/drawer_items.dart';
import 'package:e_suvidha/models/drawer_item.dart';
import 'package:e_suvidha/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    final provider = Provider.of<NavigationProvider>(context);
    final isCollapsed = provider.isCollapsed;

    return Container(
      width: isCollapsed ? MediaQuery.of(context).size.width * 0.2 : null,
      child: Drawer(
        child: Container(
          color: Colors.blueAccent,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 24).add(safeArea),
                width: double.infinity,
                color: Colors.white12,
                child: buildHeader(isCollapsed),
              ),
              buildList(items: itemsFirst, isCollapsed: isCollapsed),
              Spacer(),
              buildCollapseIcon(context, isCollapsed),
              const SizedBox(height: 12)
            ],
          ),
        ),
      ),
    );
  }

//----------------------------------------------------------------------
  Widget buildList({
    required bool isCollapsed,
    required List<DrawerItem> items,
  }) =>
      ListView.separated(
        padding: isCollapsed ? EdgeInsets.zero : padding,
        shrinkWrap: true,
        primary: false,
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = items[index];

          return buildMenuItem(
            isCollapsed: isCollapsed,
            text: item.title,
            icon: item.icon,
            onClicked: () {},
          );
        },
      );
  void selectItem(BuildContext context, int index) {
    final navigateTo = (page) => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => page,
        ));

    Navigator.of(context).pop();

    switch (index) {
      case 0:
        //navigateTo(GetStartedPage());
        break;
      case 1:
        // navigateTo(SamplesPage());
        break;
      case 2:
        // navigateTo(TestingPage());
        break;
      case 3:
        //navigateTo(PerformancePage());
        break;
      case 4:
        //navigateTo(DeploymentPage());
        break;
      case 5:
        //navigateTo(ResourcesPage());
        break;
    }
  }

  Widget buildMenuItem({
    required bool isCollapsed,
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final leading = Icon(icon, color: color);

    return Material(
      color: Colors.transparent,
      child: isCollapsed
          ? ListTile(
              title: leading,
              onTap: onClicked,
            )
          : ListTile(
              leading: leading,
              title: Text(text, style: TextStyle(color: color, fontSize: 16)),
              onTap: onClicked,
            ),
    );
  }

  //--------------------------------------------------------------------------
  Widget buildCollapseIcon(BuildContext context, bool isCollapsed) {
    final double size = 52;
    final icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    final alignment = isCollapsed ? Alignment.center : Alignment.centerRight;
    final margin = isCollapsed ? null : EdgeInsets.only(right: 16);
    final width = isCollapsed ? double.infinity : size;

    return Container(
      alignment: alignment,
      margin: margin,
      child: InkWell(
        child: Container(
          width: size,
          height: size,
          child: Icon(icon, color: Colors.white),
        ),
        onTap: () {
          final provider =
              Provider.of<NavigationProvider>(context, listen: false);

          provider.toggleIsCollapsed();
        },
      ),
    );
  }

  Widget buildHeader(bool isCollapsed) => isCollapsed
      ? Image.asset(
          "assets/images/drawer_logo.png",
          width: 50,
          height: 60,
          fit: BoxFit.fitWidth,
        )
      : Row(
          children: [
            const SizedBox(width: 24),
            Image.asset(
              "assets/images/drawer_logo.png",
              width: 50,
              height: 60,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(width: 16),
            Text('Flutter', style: TextStyle(fontSize: 32, color: Colors.white))
          ],
        );
}
