
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials/supabase/supabase_curd.dart';

class TryPage extends ConsumerStatefulWidget {
  const TryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TryPageState();
}

class _TryPageState extends ConsumerState<TryPage> {
  final nameEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Try Page'),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                ref.read(crudServiceProvider).getUserDetailsByEmail();
              },
              child: const Text("Get")),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: nameEditingController,
          ),
          ElevatedButton(
              onPressed: () {
                ref
                    .read(crudServiceProvider)
                    .updateUserDetails(nameEditingController.text);
              },
              child: const Text("Update")),
        ],
      )),
    );
  }
}
