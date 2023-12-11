// ignore_for_file: unused_field, unused_result, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:trials/erpapi/erp_data_page.dart';
import 'package:trials/erpapi/erp_repository/erp_accountgroup_repositorty.dart';

class AddPage extends ConsumerStatefulWidget {
  const AddPage({super.key});

  @override
  ConsumerState<AddPage> createState() => _AddPageConsumerState();
}

class _AddPageConsumerState extends ConsumerState<AddPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _narrController = TextEditingController();
  TextEditingController _affGpController = TextEditingController();
  TextEditingController _natController = TextEditingController();
  TextEditingController _grpUnderController = TextEditingController();
  TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Add new data',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),

                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(hintText: '   Name'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      onSaved: (value) {},
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      controller: _narrController,
                      decoration:
                          const InputDecoration(hintText: '  Narration'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      onSaved: (value) {},
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      controller: _natController,
                      decoration: const InputDecoration(hintText: '  Nature'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      onSaved: (value) {},
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      controller: _grpUnderController,
                      decoration:
                          const InputDecoration(hintText: 'Group Under'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      onSaved: (value) {},
                    ),
                  ),
                ),
       
                // const SizedBox(height: 20),
                // Container(
                //   height: 50,
                //   decoration: BoxDecoration(
                //     border: Border.all(),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 8.0),
                //     child: TextFormField(
                //       controller: _idController,
                //       decoration: const InputDecoration(hintText: '  Id'),
                //       validator: FormBuilderValidators.compose([
                //         FormBuilderValidators.required(),
                //       ]),
                //       onSaved: (value) {},
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(accountGroupsProvider)
                            .CreateOrEdit(
                              _nameController.value.text,
                              _narrController.value.text,
                              _affGpController.text == 'true',
                             int.parse(_natController.text),
                             int.parse(_grpUnderController.text)
                            //  int.parse(_idController.text),
                            )
                            .then((value) {
                          Get.to(() => const DataPage());
                          ref.refresh(accountGroupsProvider);
                        });
                      }
                    },
                    child: const Text('Add Data'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
