import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:trials/erpapi/erp_data_page.dart';
import 'package:trials/erpapi/erp_model/dropdown_model.dart';
// import 'package:trials/demo/getapi/api_model.dart';
import 'package:trials/erpapi/erp_repository/erp_accountgroup_repositorty.dart';
import 'package:trials/erpapi/erp_services/erp_dropdown_service.dart';

import 'erp_model/erp_accountgroup_model.dart';

class ReactivePage extends ConsumerStatefulWidget {
  const ReactivePage({super.key});

  @override
  ConsumerState<ReactivePage> createState() => _ReactivePageState();
}

class _ReactivePageState extends ConsumerState<ReactivePage> {
  String dropdownValue = 'Primary';
  late int dropValue;
  final _formKey = GlobalKey<FormState>();
  Item? item;
  FormGroup logGroup(Item? item) {
    return FormGroup({
      'name': FormControl<String>(
          value: item?.name, validators: [Validators.required]),
      'narration': FormControl<String>(
          value: item?.name, validators: [Validators.required]),
      'affectGrossProfit':
          FormControl<String>(value: "false",),
      'accountGroupName': FormControl<String>(
        value: item?.accountGroupName,
        validators: [Validators.required],
      ),
      'nature': FormControl<int>(
        value: 0,
        // validators: [Validators.required],
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(accountGroupFutureProvider);
    // ignore: unused_local_variable
    final group = ref.watch(accountdropFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reactive Page'),
      ),
      body: SingleChildScrollView(
        child: detail.when(
          data: (data) {
            return ReactiveFormBuilder(form: () {
              return logGroup(item);
            }, builder: (context, formGroup, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Name",
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ReactiveTextField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    formControlName: 'name',
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // const Text(
                              //   "Affect Gross Profit",
                              //   style: TextStyle(fontSize: 14),
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // Container(
                              //   height: 50,
                              //   decoration: BoxDecoration(
                              //     border:
                              //         Border.all(color: Colors.grey, width: 1),
                              //     borderRadius: BorderRadius.circular(5),
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: ReactiveTextField(
                              //       textInputAction: TextInputAction.next,
                              //       keyboardType: TextInputType.text,
                              //       formControlName: 'affectGrossProfit',
                              //       decoration: const InputDecoration(
                              //           border: InputBorder.none),
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Narration",
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ReactiveTextField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    formControlName: 'narration',
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
      
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Account Group Name",
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            Container(
                                height: 50,
      
                                // decoration: BoxDecoration(
                                //   border:
                                //       Border.all(color: Colors.grey, width: 1),
                                //   borderRadius: BorderRadius.circular(5),
                                // ),
      
                                child: group.when(data: (data) {
                                  return DropdownMenu<GroupDropdownModel>(
                                    initialSelection: data.first,
                                    onSelected: (GroupDropdownModel? value) {
                                      setState(() {
                                        dropValue = value!.id;
                                        formGroup.control('nature').value =
                                            value.nature;
                                        formGroup
                                            .control('affectGrossProfit')
                                            .value = value.affectGrossProfit.toString();
                                      });
                                    },
                                    dropdownMenuEntries: data.map<
                                            DropdownMenuEntry<
                                                GroupDropdownModel>>(
                                        (GroupDropdownModel value) {
                                      return DropdownMenuEntry<
                                              GroupDropdownModel>(
                                          value: value, label: value.displayName);
                                    }).toList(),
                                  );
                                }, error: (error, _) {
                                  return Text(error.toString());
                                }, loading: () {
                                  return const SizedBox();
                                }),
                              ),
                              // Container(
                              //   height: 50,
                              //   decoration: BoxDecoration(
                              //     border:
                              //         Border.all(color: Colors.grey, width: 1),
                              //     borderRadius: BorderRadius.circular(5),
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: ReactiveTextField(
                              //       textInputAction: TextInputAction.next,
                              //       keyboardType: TextInputType.text,
                              //       formControlName: 'accountGroupName',
                              //       decoration: const InputDecoration(
                              //           border: InputBorder.none),
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Nature",
                                style: TextStyle(fontSize: 15),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ReactiveTextField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    autofillHints: const <String>[
                                      AutofillHints.telephoneNumber
                                    ],
                                    formControlName: 'nature',
                                  ),
                                ),
                              ),
                                        const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Affect Gross Profit",
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ReactiveTextField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    formControlName: 'affectGrossProfit',
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                             const SizedBox(
                                height: 20,
                              ),  
                              Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      ref
                                          .read(accountGroupsProvider)
                                          .CreateOrEdit(
                                            formGroup.control('name').value,
                                            formGroup.control('narration').value,
                                            // formGroup
                                            //     .control('affectGrossProfit')
                                            //     .value  == "true"? true : false,
                                            dropValue,
                                            formGroup.control('nature').value,
                                              formGroup
                                                .control('affectGrossProfit')
                                                .value  == "true"? true : false,
                                    
                                    
                                          
                                          )
                                          .then((value) {
                                        Get.to(() => const DataPage());
                                        ref.refresh(accountGroupsProvider);
                                      });
                                    },
                                    child: const Text('Submit')),
                              ),
                            ]),
                      ]),
                ),
              );
            });
          },
          error: (Object error, StackTrace stackTrace) {
            return Text(error.toString());
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
