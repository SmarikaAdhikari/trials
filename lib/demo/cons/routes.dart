
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:trials/erpapi/erp_data_page.dart';
import 'package:trials/erpapi/login_page.dart';
import 'package:trials/demo/getapi/provider.dart';
import 'package:trials/demo/postapi/logs.dart';
import 'package:trials/main.dart';

List <GetPage> page =
[
     GetPage(
    name: '/home',
    page: () => const  MyHomePage(title: 'Flutter Demo Home Page'),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
    GetPage(
    name: '/log',
    page: () => const LogsPage(),
    transition: Transition.leftToRight,
    transitionDuration: const Duration(milliseconds: 500),
  ),
    GetPage(
    name: '/acc',
    page: () => const AccountPage(),
    transition: Transition.circularReveal,
    transitionDuration: const Duration(milliseconds: 1000),
  ),
      GetPage(
    name: '/login',
    page: () => const LoginPage(),
    transition: Transition.circularReveal,
    transitionDuration: const Duration(milliseconds: 1000),
  ),
       GetPage(
    name: '/data',
    page: () => const DataPage(),
    transition: Transition.circularReveal,
    transitionDuration: const Duration(milliseconds: 1000),
  )

];


