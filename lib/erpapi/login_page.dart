import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:trials/erpapi/erp_services/erp_service.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   title: const Text('Login', style: TextStyle(color: Colors.white)),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Welcome to the App ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),

            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 225, 243, 252),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                autofillHints: const [AutofillHints.email],
                controller: emailEditingController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: InputBorder.none,
                    labelText: 'E-mail'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
                onSaved: (value) {},
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 225, 243, 252),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: passwordEditingController,
                autofillHints: const [AutofillHints.password],
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: InputBorder.none,
                    labelText: 'Password'),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                ]),
                onSaved: (value) {},
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.all(13.0),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(logInProvider).login(emailEditingController.text,
                      passwordEditingController.text, context);
                  // Get.to(const DataPage());
                }
              },
            ),
            // const SizedBox(height: 350),
            const Spacer(),
            Row(
              children: [
                const SizedBox(width: 20),
                const Text("Don't have an account?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    )),
                const SizedBox(width: 15),
                ElevatedButton(onPressed: () {}, child: const Text("Sign Up")),
              ],
            ),
            const SizedBox(
              height: 15,
            )
          ]),
        ),
      ),
    );
  }
}
