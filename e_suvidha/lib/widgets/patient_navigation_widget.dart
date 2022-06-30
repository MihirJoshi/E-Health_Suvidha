import 'package:e_suvidha/pages/Admin/add_doctor.dart';
import 'package:e_suvidha/pages/Patient/a_blood_detail.dart';
import 'package:e_suvidha/pages/Patient/a_blood_history.dart';
import 'package:e_suvidha/pages/Patient/donate_blood_details.dart';
import 'package:e_suvidha/pages/Patient/donate_blood_history.dart';
import 'package:e_suvidha/pages/Patient/lab_history.dart';
import 'package:e_suvidha/pages/Patient/p_consult.dart';
import 'package:e_suvidha/utils/app_themes.dart';
import 'package:e_suvidha/custom_drawer/p_drawer_custom_user.dart';
import 'package:e_suvidha/custom_drawer/p_home_drawer.dart';
import 'package:e_suvidha/pages/Patient/p_feedback_screen.dart';
import 'package:e_suvidha/pages/Patient/p_help_screen.dart';
import 'package:e_suvidha/pages/Patient/p_home_screen.dart';
import 'package:e_suvidha/pages/Patient/p_invite_friend.dart';
import 'package:flutter/material.dart';

class PNavigationHomeScreen extends StatefulWidget {
  @override
  _PNavigationHomeScreenState createState() => _PNavigationHomeScreenState();
}

class _PNavigationHomeScreenState extends State<PNavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const PatientHomePage();
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
          body: PDrawerUserController(
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
            screenView = const PatientHomePage();
          });
          break;
        case DrawerIndex.LabHistory:
          setState(() {
            screenView = LabHistory();
          });
          break;
        case DrawerIndex.ApplyBlood:
          setState(() {
            screenView = ApplyBloodHistory();
          });
          break;
        case DrawerIndex.Consult:
          setState(() {
            screenView = PConsult();
          });
          break;
        case DrawerIndex.DonateBlood:
          setState(() {
            screenView = DonateBloodHistory();
          });
          break;
        default:
          break;
      }
    }
  }
}
