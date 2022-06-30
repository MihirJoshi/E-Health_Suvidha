//import 'package:e_suvidha/pages/a_home_screen.dart';
import 'package:e_suvidha/common/women_data_model.dart';
import 'package:e_suvidha/pages/Admin/a_apply_blood.dart';
import 'package:e_suvidha/pages/Admin/a_apply_detail.dart';
import 'package:e_suvidha/pages/Admin/a_donate_blood.dart';
import 'package:e_suvidha/pages/Admin/a_donate_detail.dart';
import 'package:e_suvidha/pages/Admin/add_tech.dart';
import 'package:e_suvidha/pages/Admin/assign_tech.dart';
import 'package:e_suvidha/pages/Admin/detail_test.dart';
import 'package:e_suvidha/pages/Admin/show_assign_tech.dart';
import 'package:e_suvidha/pages/Admin/show_patient_tech.dart';
import 'package:e_suvidha/pages/Doctor/add_time.dart';
import 'package:e_suvidha/pages/Doctor/d_consult.dart';
import 'package:e_suvidha/pages/Doctor/detail_patient.dart';
import 'package:e_suvidha/pages/Patient/a_blood_detail.dart';
import 'package:e_suvidha/pages/Patient/a_blood_history.dart';
import 'package:e_suvidha/pages/Patient/apply_blood_form.dart';
import 'package:e_suvidha/pages/Patient/blood_home.dart';
import 'package:e_suvidha/pages/Patient/body_covid_lab.dart';
import 'package:e_suvidha/pages/Patient/book_lab_form.dart';
import 'package:e_suvidha/pages/Patient/common_issue_page.dart';
import 'package:e_suvidha/pages/Patient/common_issues_doctor.dart';
import 'package:e_suvidha/pages/Patient/consult.dart';
import 'package:e_suvidha/pages/Patient/consult_form.dart';
import 'package:e_suvidha/pages/Patient/detail_doctor.dart';
import 'package:e_suvidha/pages/Patient/donate_blood.dart';
import 'package:e_suvidha/pages/Patient/donate_blood_details.dart';
import 'package:e_suvidha/pages/Patient/donate_blood_history.dart';
import 'package:e_suvidha/pages/Patient/hair.dart';
import 'package:e_suvidha/pages/Patient/join_gmeet.dart';
import 'package:e_suvidha/pages/Patient/lab_detail.dart';
import 'package:e_suvidha/pages/Patient/lab_home.dart';
import 'package:e_suvidha/pages/Patient/p_consult.dart';
import 'package:e_suvidha/pages/Patient/period_symptoms.dart';
import 'package:e_suvidha/pages/Patient/renal_lab.dart';
import 'package:e_suvidha/pages/Patient/show_lab_history.dart';
import 'package:e_suvidha/pages/Patient/women_page.dart';
import 'package:e_suvidha/pages/a_login_page.dart';
import 'package:e_suvidha/pages/d_home_screen.dart';
import 'package:e_suvidha/pages/d_login_page.dart';
import 'package:e_suvidha/pages/main_page.dart';
import 'package:e_suvidha/pages/p_home_screen.dart';
import 'package:e_suvidha/pages/p_login_page.dart';
import 'package:e_suvidha/pages/p_register_page.dart';
import 'package:e_suvidha/pages/p_reset_pass.dart';
import 'package:e_suvidha/utils/routes.dart';
import 'package:e_suvidha/widgets/admin_navigation_home_widget.dart';
import 'package:e_suvidha/widgets/doctor_navigation_widget.dart';
import 'package:e_suvidha/widgets/patient_navigation_widget.dart';
import 'package:e_suvidha/widgets/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(HealthSuvidha());
}

class HealthSuvidha extends StatelessWidget {
  const HealthSuvidha({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.splashRoute,
      routes: {
        MyRoutes.splashRoute: (context) => SplashScreen(),
        MyRoutes.mainPageRoute: (context) => Main_Page(),
        MyRoutes.ploginRoute: (context) => PLoginPage(),
        MyRoutes.pregisterRoute: (context) => PRegistration(),
        MyRoutes.aloginRoute: (context) => ALoginPage(),
        MyRoutes.phomeRoute: (context) => PNavigationHomeScreen(),
        MyRoutes.ahomeRoute: (context) => NavigationHomeScreen(),
        MyRoutes.dloginRoute: (context) => DLoginPage(),
        MyRoutes.dhomeRoute: (context) => DNavigationHomeScreen(),
        MyRoutes.consult: (context) => ConsultPage(),
        MyRoutes.common_ui: (context) => CommonDocotrPage(),
        MyRoutes.women_page: (context) => WomenPage(),
        MyRoutes.hair: (context) => HairPage(),
        MyRoutes.common_page: (context) => CommonPage(),
        MyRoutes.period_page: (context) => PeriodPage(),
        MyRoutes.consult_form: (context) => ConsultForm(),
        MyRoutes.add_time: (context) => AddTime(),
        MyRoutes.d_consult: (context) => DConsult(),
        MyRoutes.p_detail: (context) => PDetail(),
        MyRoutes.p_consult: (context) => PConsult(),
        MyRoutes.d_detail: (context) => DDetail(),
        MyRoutes.lab_home: (context) => LabHome(),
        MyRoutes.lab_detail: (context) => LabDetail(),
        MyRoutes.covid_lab: (context) => CovidLab(),
        MyRoutes.renal_lab: (context) => RenalLab(),
        MyRoutes.book_lab_form: (context) => LabForm(),
        MyRoutes.show_lab: (context) => ShowLab(),
        MyRoutes.show_lab_history: (context) => ShowLabHistory(),
        MyRoutes.assign_tech: (context) => AssignTech(),
        MyRoutes.add_tech: (context) => AddTech(),
        MyRoutes.blood_home: (context) => BloodHome(),
        MyRoutes.show_assign_tech: (context) => ShowAssignTech(),
        MyRoutes.show_patient_tech: (context) => ShowPatientTech(),
        MyRoutes.apply_blood: (context) => ApplyBlood(),
        MyRoutes.reset_pass: (context) => ResetPass(),
        MyRoutes.donate_blood: (context) => DonateBlood(),
        MyRoutes.a_blood_history: (context) => ApplyBloodHistory(),
        MyRoutes.a_blood_detail: (context) => ApplyBloodDetail(),
        MyRoutes.d_blood_detail: (context) => DonateBloodDetail(),
        MyRoutes.d_blood_history: (context) => DonateBloodHistory(),
        MyRoutes.join_gmeet: (context) => Join_Gmeet(),
        MyRoutes.a_apply_blood: (context) => AdminApplyBlood(),
        MyRoutes.a_apply_detail: (context) => AdminApplyBloodDetail(),
        MyRoutes.a_donate_blood: (context) => AdminDonateBlood(),
        MyRoutes.a_donate_detail: (context) => AdminDonateBloodDetail(),
        //MyRoutes.adddocRoute: (context) => AddDoctor(),
      },
    );
  }
}
