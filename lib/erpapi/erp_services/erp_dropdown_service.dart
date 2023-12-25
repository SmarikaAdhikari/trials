import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials/dio.dart';
import 'package:trials/erpapi/erp_model/dropdown_model.dart';

final accountdropFutureProvider =
    FutureProvider.autoDispose<List<GroupDropdownModel>>((ref) async {
  final ApiService = ref.watch(dropServiceProvider);
  return ApiService.getDrop();
});

class DropService {
  Future<List<GroupDropdownModel>> getDrop() async {
    const url =
        "https://erpapi.suktas.com/api/services/app/AccountGroups/GetAllAccountGroupForTableDropdown";
    try {
      final res = await Api().get(url);
      List data = json.decode(res.data)['result'];
      print(data);
      // return data.map((e) => GroupDropdownModel.fromJson(e)).toList();
      return data.map((e) => GroupDropdownModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Error getting suggestion $e');
    }
  }
}

final dropServiceProvider = Provider<DropService>((ref) => DropService());
