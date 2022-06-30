import 'package:e_suvidha/pages/Admin/a_apply_blood.dart';
import 'package:e_suvidha/pages/Admin/a_donate_blood.dart';
import 'package:e_suvidha/pages/Admin/add_doctor.dart';
import 'package:e_suvidha/pages/Admin/add_tech.dart';
import 'package:e_suvidha/utils/app_themes.dart';
import 'package:e_suvidha/custom_drawer/drawer_custom_user.dart';
import 'package:e_suvidha/custom_drawer/home_drawer.dart';
import 'package:e_suvidha/pages/Admin/lab_tests.dart';
import 'package:e_suvidha/pages/Admin/help_screen.dart';
import 'package:e_suvidha/pages/Admin/home_screen.dart';
import 'package:e_suvidha/pages/Admin/invite_friend_screen.dart';
import 'package:flutter/material.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
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
          body: DrawerUserController(
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
            screenView = const MyHomePage();
          });
          break;
        case DrawerIndex.AddDoctor:
          setState(() {
            screenView = AddDoctor();
          });
          break;
        case DrawerIndex.LabTests:
          setState(() {
            screenView = LabTests();
          });
          break;
        case DrawerIndex.AddTechnician:
          setState(() {
            screenView = AddTech();
          });
          break;
        case DrawerIndex.ApplyBlood:
          setState(() {
            screenView = AdminApplyBlood();
          });
          break;
        case DrawerIndex.DonateBlood:
          setState(() {
            screenView = AdminDonateBlood();
          });
          break;
        default:
          break;
      }
    }
  }
}
