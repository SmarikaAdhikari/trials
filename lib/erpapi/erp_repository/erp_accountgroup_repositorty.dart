// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, unused_local_variable

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials/dio.dart';
import 'package:trials/erpapi/erp_model/erp_accountgroup_model.dart';

final accountGroupFutureProvider =
    FutureProvider.autoDispose<AccountGroupModel>((ref) async {
  final ApiService = ref.watch(accountGroupsProvider);
  return ApiService.getAccountGroups();
});

class AccountGroupsService {
  Future<AccountGroupModel> getAccountGroups() async {
    const url =
        "http://erpapi.suktas.com/api/services/app/AccountGroups/GetAll";
    try {
      final res = await Api().get(url);
      final data = json.decode(res.data)['result'];
      print(data);
      return AccountGroupModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> CreateOrEdit(
    String name,
    String narration,
    // String accountGroupName,
    // bool affectGrossProfit,
    // bool isDefault,
    
    int groupUnder,
    int nature,
    bool affectGrossProfit,
  ) async {
    const url =
        "https://erpapi.suktas.com/api/services/app/AccountGroups/CreateOrEdit";
    var datta = {
      "name": name,
      "narration": narration,
      "affectGrossProfit": affectGrossProfit,
      "nature": nature,
      "groupUnder": groupUnder,
      // "accountGroupName": accountGroupName,
    };
    try {
      final res = await Api().post(url, data: datta);
      final data = json.decode(res.data)["result"];
    } catch (e) {
    rethrow;
    }
  }

  Future<void> Delete(int id) async {
    const url =
        "https://erpapi.suktas.com/api/services/app/AccountGroups/Delete";

    try {
      final res = await Api().delete(url, queryParameters: {"id": id});
      final data = json.decode(res.data)["result"];
    } catch (e) {
      rethrow;
    }
  }
}

final accountGroupsProvider =
    Provider<AccountGroupsService>((ref) => AccountGroupsService());
