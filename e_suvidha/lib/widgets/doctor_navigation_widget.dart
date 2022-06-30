import 'package:e_suvidha/pages/Admin/add_doctor.dart';
import 'package:e_suvidha/pages/Doctor/add_time.dart';
import 'package:e_suvidha/utils/app_themes.dart';
import 'package:e_suvidha/custom_drawer/d_drawer_custom.dart';
import 'package:e_suvidha/custom_drawer/d_home_drawer.dart';
import 'package:e_suvidha/pages/Doctor/d_feedback_screen.dart';
import 'package:e_suvidha/pages/Doctor/d_help_screen.dart';
import 'package:e_suvidha/pages/Doctor/d_home_screen.dart';
import 'package:e_suvidha/pages/Doctor/d_consult.dart';
import 'package:flutter/material.dart';

class DNavigationHomeScreen extends StatefulWidget {
  @override
  _DNavigationHomeScreenState createState() => _DNavigationHomeScreenState();
}

class _DNavigationHomeScreenState extends State<DNavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const DoctorHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DDrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = const DoctorHomePage();
          });
          break;
        case DrawerIndex.AddTime:
          setState(() {
            screenView = AddTime();
          });
          break;

        case DrawerIndex.Consult:
          setState(() {
            screenView = DConsult();
          });
          break;
        default:
          break;
      }
    }
  }
}
