// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, body_might_complete_normally_nullable, unused_local_variable, unnecessary_null_comparison


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trials/demo/cons/constants.dart';
import 'package:trials/demo/getapi/provider.dart';

import 'package:trials/dio.dart';

// bool userLoggedIn = false;
class Logs {
  Future<int?> login(
      String email, String password, BuildContext context) async {
    const url = "http://campusapi.suktas.com/api/TokenAuth/Authenticate";
    // const url = "https://academiapi.suktas.com/api/TokenAuth/Authenticate";
    var data = {
      "userNameOrEmailAddress": email,
      "password": password,
    };
    try {
      final res = await Api().post(url, data: data);
          // print(data);   
        var token = json.decode(res.data)['result']['accessToken'];
          await setValue(accessToken, token);
          // print(res.data);
        
       Get.to(const AccountPage());


    } catch (e) {
      return null;
   
    }
  }
   Future getTrial() async {
    try {
      final res = await Api().get('https://dogapi.dog/api/facts');
    } catch (e) {
      throw Exception('Error getting suggestion $e');
    }
    return null;
  }
}

final loginProvider = Provider<Logs>((ref) => Logs());
