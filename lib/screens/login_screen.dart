import 'package:app_form_validations/providers/login_from_provider.dart';
import 'package:app_form_validations/ui/input_decorations.dart';
import 'package:app_form_validations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 250),
            CardContainer(
                child: Column(
              children: [
                const SizedBox(height: 10),
                Text('Login', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => LoginFromProvider(),
                  child: _LoginForm(),
                ),
              ],
            )),
            const SizedBox(height: 50),
            const Text('Crear una nueva cuenta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),
          ],
        ),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFromProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          TextFormField(
            onChanged: (value) => loginForm.email = value,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'john.doe@gmail.com',
              labelText: 'Emial',
              prefixIcon: Icons.alternate_email_outlined,
            ),
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Emial is not correct';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            onChanged: (value) => loginForm.password = value,
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: '*******',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline,
            ),
            validator: (value) => (value != null && value.length >= 6)
                ? null
                : 'Password must be at least 6 characters long',
          ),
          const SizedBox(height: 30),
          MaterialButton(
              onPressed: () {
                if (!loginForm.isValidForm()) return;
                Navigator.pushReplacementNamed(context, 'home');
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: const Text(
                  'Log in',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ]),
      ),
    );
  }
}
