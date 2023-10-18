
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trials/demo/cons/constants.dart';
import 'package:trials/demo/getapi/api_service.dart';
import 'package:trials/demo/logs.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(accountFutureProvider);
  

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          IconButton(
            onPressed: () async{
              await setValue(accessToken, "");
              Get.to(const LogsPage());
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      
            body: details.when(data: (
        data,
      ) {
        return ListView.builder(
          itemCount: data.items.length,
          // itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              horizontalTitleGap: 1,
              // title: Text(data.totalCount.toString()),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: ListTile(
                      title: Text(data.items[index].name),
                      subtitle: Text(data.items[index].id.toString()),
                      
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }, error: (error, _) {
        return Text(error.toString());
      }, loading: () {
        return const SizedBox();
      }),
    );
  }
}