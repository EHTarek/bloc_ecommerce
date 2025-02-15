import 'package:bloc_ecommerce/core/extentions/go_router_extention.dart';
import 'package:bloc_ecommerce/core/navigation/routes.dart';
import 'package:bloc_ecommerce/features/authentication/presentation/widget/link_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const FlutterLogo(size: 100),
            const SizedBox(height: 80),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'First Name',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Last Name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Continue'),
            ),
            LinkText(
              text: 'Already have an account? ',
              linkText: 'Sign in',
              onTap: () {
                context.pushNamedAndRemoveUntil(Routes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
