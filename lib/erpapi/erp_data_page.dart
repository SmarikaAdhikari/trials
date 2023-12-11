import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trials/demo/cons/constants.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:trials/demo/cons/constants.dart';
import 'package:trials/erpapi/erp_add_datapage.dart';
import 'package:trials/erpapi/erp_repository/erp_accountgroup_repositorty.dart';
import 'package:trials/erpapi/login_page.dart';
// import 'package:trials/erpapi/login_page.dart';

class DataPage extends ConsumerWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(accountGroupFutureProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Account Group Data',
            style: TextStyle(color: Colors.white)),
        actions: [
          Row(
            children: [
              Card(
                child: IconButton(
                  onPressed: () {
                    Get.to(const AddPage());
                  },
                  icon: const Icon(Icons.add, color: Colors.black),
                ),
              ),
                    Card(
                      child: IconButton(
                                onPressed: () async {
                                  await setValue(accessToken, "");
                                  Get.to(const LoginPage());
                                },
                                icon: const Icon(Icons.exit_to_app, color: Colors.black),
                              ),
                    )
            ],
          ),
          // IconButton(
          //   onPressed: () async {
          //     await setValue(accessToken, "");
          //     Get.to(const LoginPage());
          //   },
          //   icon: const Icon(Icons.exit_to_app, color: Colors.white),
          // )
        ],
      ),
      body: detail.when(data: (
        data,
      ) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.items.length,
            itemBuilder: (context, index) {
              return Card(
                color: const Color.fromARGB(255, 225, 243, 252),
                // decoration: BoxDecoration(
                //     color: const Color.fromARGB(255, 225, 243, 252),
                //     borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  horizontalTitleGap: 10,
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Text(
                                  "Id: ${data.items[index].id.toString()}",
                                  style: const TextStyle(fontSize: 15)),
                              const SizedBox(
                                width: 10,
                              ),
                              // Text("/ Nat: ${data.items[index].nature}",
                              //     style: const TextStyle(
                              //       fontSize: 15,
                              //     )),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text("Name: ${data.items[index].name}",
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
                              // const SizedBox(
                              //   width: 15,
                              // ),
                              const Spacer(),
                              Text("Nat: ${data.items[index].nature}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              "AccGpname: ${data.items[index].accountGroupName}",
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                        ],
                      ),
                      // const Text("wow",
                      //     style: TextStyle(
                      //       fontSize: 15,
                      //     )),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }, error: (error, _) {
        return Text(error.toString());
      }, loading: () {
        return const SizedBox();
      }),
    );
  }
}
