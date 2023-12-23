
// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:trials/erpapi/erp_data_page.dart';
import 'package:trials/erpapi/erp_repository/erp_accountgroup_repositorty.dart';

class Edit extends ConsumerStatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Edit({super.key, required this.name, required this.narration,
  //  required this.accountGroupName
   });

  final String name;
  final String narration;
  // final String accountGroupName ;

  @override
  ConsumerState<Edit> createState() => _EditState();
}

class _EditState extends ConsumerState<Edit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _narrController = TextEditingController();
  // final TextEditingController _accGroupNameController =
  //     TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.name;
    _narrController.text = widget.narration;

    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "Name",
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: TextField(
              controller: _narrController,
              decoration: const InputDecoration(
                hintText: "Narration",
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
                ref
                            .read(accountGroupsProvider)
                            .CreateOrEdit(
                                _nameController.value.text,
                                _narrController.value.text
                         
                      

                                
                                )
                            .then((value) {
                          Get.to(() => const DataPage());
                          ref.refresh(accountGroupsProvider);
              });
            },
            child: const Text("Done"),
          ),
        ],
      )),
    );
  }
}
