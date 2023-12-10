import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials/erpapi/erp_repository/erp_accountgroup_repositorty.dart';

class DataPage extends ConsumerWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(accountGroupFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Group Data'),
      ),
      body: detail.when(data: (
        data,
      ) {
        return ListView.builder(
          itemCount: data.items.length,
          itemBuilder: (context, index) {
            return ListTile(
              horizontalTitleGap: 1,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: ListTile(
                      // title: Text("hey"),
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
