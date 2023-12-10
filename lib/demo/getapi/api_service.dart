// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials/demo/getapi/api_model.dart';
import 'package:trials/dio.dart';

final ServiceProvider = Provider<AccountService>((ref) => AccountService());

final accountFutureProvider = FutureProvider.autoDispose<Account>((ref) async {
  final ApiService = ref.watch(ServiceProvider);
  return ApiService.getAccounts();
});

class AccountService {
  Future<Account> getAccounts() async {
    const url =
        "http://campusapi.suktas.com/api/services/app/AccountLedgers/GetAll";
    try {
      final res = await Api().get((url));
      final data = json.decode(res.data)['result'];
      // print(data);
      // Get.to(const AccountPage());

      return Account.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
