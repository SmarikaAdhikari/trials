// ignore_for_file: unused_field, unused_result, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:trials/erpapi/erp_data_page.dart';
// import 'package:trials/erpapi/erp_model/erp_accountgroup_model.dart';
import 'package:trials/erpapi/erp_repository/erp_accountgroup_repositorty.dart';

class AddPage extends ConsumerStatefulWidget {
  const AddPage({super.key});

  @override
  ConsumerState<AddPage> createState() => _AddPageConsumerState();
}

class _AddPageConsumerState extends ConsumerState<AddPage> {
  late int accValue;
  String selectedValue = 'Option 1';
  List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3'];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _narrController = TextEditingController();
  TextEditingController _accGroupcontroller = TextEditingController();
  TextEditingController _affGpController = TextEditingController();
  TextEditingController _isdeffController = TextEditingController();
  TextEditingController _natcontroller =
      TextEditingController(text: 'Default Value');
  TextEditingController _grpUndercontroller =
      TextEditingController(text: 'Default Value');
  // TextEditingController _natController = TextEditingController();
  // TextEditingController _grpUnderController = TextEditingController();
  // TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final accProvider = ref.watch(accountGroupsProvider);
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
                      enabled: false,

                      // controller: _natController,

                      decoration: const InputDecoration(hintText: ' Nature'),

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
                      enabled: false,
                      //  controller: Text("de") ,
                      // controller: _grpUnderController,
                      decoration: const InputDecoration(
                          hintText: 'Group Under control '),

                      onSaved: (value) {},
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Container(
                //   height: 50,
                //   decoration: BoxDecoration(
                //     border: Border.all(),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 8.0),
                //     child: TextFormField(
                //       controller: _isdeffController,
                //       decoration:
                //           const InputDecoration(hintText: 'Default'),
                //       validator: FormBuilderValidators.compose([
                //         FormBuilderValidators.required(),
                //       ]),
                //       onSaved: (value) {},
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20),
                // Container(
                //   height: 50,
                //   decoration: BoxDecoration(
                //     border: Border.all(),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 8.0),
                //     child: TextField(
                //       decoration: InputDecoration(
                //         labelText: 'Select an option',
                //         suffixIcon: DropdownButton<String>(
                //           value: selectedValue,
                //           onChanged: (String? newValue) {
                //             setState(() {
                //               selectedValue = newValue!;
                //             });
                //           },
                //           items: dropdownItems
                //               .map<DropdownMenuItem<String>>((String value) {
                //             return DropdownMenuItem<String>(
                //               value: value,
                //               child: Text(selectedValue),
                //             );
                //           }).toList(),
                //         ),
                //       ),
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
                              // false,
                              100,
                              1,
                               false,

                              // _accGroupcontroller.value.text,
                              // _affGpController.text == 'false',
                              // _isdeffController.text == 'false',
                              // int.parse(_natcontroller.text),
                              // int.parse(_grpUndercontroller.text)
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
