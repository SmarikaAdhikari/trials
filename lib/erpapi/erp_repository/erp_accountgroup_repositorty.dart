// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials/dio.dart';
import 'package:trials/erpapi/erp_model/erp_accountgroup_model.dart';


final AccountGroupsProvider =
    Provider<AccountGroupsService>((ref) => AccountGroupsService());

final accountGroupFutureProvider =
    FutureProvider.autoDispose<AccountGroupModel>((ref) async {
  final ApiService = ref.watch(AccountGroupsProvider);
  return ApiService.getAccountGroups();
});

class AccountGroupsService {
  Future<AccountGroupModel> getAccountGroups() async {
    const url =
        "http://erpapi.suktas.com/api/services/app/AccountGroups/GetAll";
    try {
      final res = await Api().get((url));
      final data = json.decode(res.data)['result'];
      // print(data);
      return AccountGroupModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
