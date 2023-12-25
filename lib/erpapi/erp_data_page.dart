// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trials/demo/cons/constants.dart';
import 'package:trials/erpapi/erp_add_datapage.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:trials/demo/cons/constants.dart';
// import 'package:trials/erpapi/erp_add_datapage.dart';
import 'package:trials/erpapi/erp_edit.dart';
import 'package:trials/erpapi/erp_model/dropdown_model.dart';
import 'package:trials/erpapi/erp_repository/erp_accountgroup_repositorty.dart';
import 'package:trials/erpapi/erp_services/erp_dropdown_service.dart';
import 'package:trials/erpapi/login_page.dart';
import 'package:trials/erpapi/reactive_page.dart';
// import 'package:trials/erpapi/login_page.dart';

class DataPage extends ConsumerWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _narrController = TextEditingController();
    TextEditingController _affGpController = TextEditingController();
    TextEditingController _isdeffController = TextEditingController();
    TextEditingController _natcontroller =
        TextEditingController(text: 'Default Value');
    TextEditingController _grpUndercontroller =
        TextEditingController(text: 'Default Value');

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
                    // Get.to(const AddPage());
                     Get.to(const ReactivePage());
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
                              Text("Id: ${data.items[index].id.toString()}",
                                  style: const TextStyle(fontSize: 15)),
                                 const  SizedBox(width: 10),
                                  Text(  "/ AffGross: ${data.items[index].affectGrossProfit}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                  )),
                              const Spacer(),
                                      detail.when(
                                data: (data) => Card(
                                  child:
                                IconButton(
                                  onPressed: () {
                                          ref
                                              .read(accountGroupsProvider)
                                              .Delete(data.items[index].id)
                                              .then((value) {
                                            ref.refresh(accountGroupFutureProvider);
                                          });

                                
                                  },
                                  icon: const Icon(Icons.delete)),
                                ),
                                error: (Object error, StackTrace stackTrace) {
                                  return Text(error.toString());
                                },
                                loading: () {
                                  return const CircularProgressIndicator();
                                },
                              ),
                              // IconButton(
                              //     onPressed: () {
                              //       ref.read(accountGroupsProvider).Delete(data.items[index].id.toString()).then((value) {
                              //         ref.refresh(accountGroupFutureProvider);
                              //       });
                              //     },
                              //     icon: const Icon(Icons.delete)),
                           
                            ],
                          ),
                          const SizedBox(
                            height: 2,
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
                          Row(
                            children: [
                              Text("Narration: ${data.items[index].narration}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                  )),
                              
                              const Spacer(),
                              // Card(
                              //   child: IconButton(
                              //       onPressed: () {
                              //         Get.to(() => Edit(
                              //             data.items[index].name,
                              //             data.items[index].narration,
                              //            ));
                              //       },
                              //       icon: const Icon(Icons.edit)),
                              // ),
                              detail.when(
                                data: (data) => Card(
                                  child:
                                   IconButton(
                                    onPressed: () {
                                      Get.to(() => Edit(
                                            name: data.items[index].name,
                                            // accountGroupName:
                                            //     data.items[index].accountGroupName!,
                                            narration: data.items[index].narration!,
                                          ));
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                ),
                                error: (Object error, StackTrace stackTrace) {
                                  return Text(error.toString());
                                },
                                loading: () {
                                  return const CircularProgressIndicator();
                                },
                              ),
                            ],
                          ),
                             Text("AccGroupname: ${data.items[index].accountGroupName}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                  )),
                                  // const SizedBox( height: 10),
                                  //       Text("Affect: ${data.items[index].affectGrossProfit}",
                                  // style: const TextStyle(
                                  //   fontSize: 15,
                                  // )),
                        ],
                      ),
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

