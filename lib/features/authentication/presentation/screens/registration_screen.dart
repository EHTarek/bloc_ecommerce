import 'package:bloc_ecommerce/common/widgets/custom_textfield_widget.dart';
import 'package:bloc_ecommerce/core/extentions/go_router_extention.dart';
import 'package:bloc_ecommerce/core/extra/validator.dart';
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
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              const FlutterLogo(size: 100),
              const SizedBox(height: 80),
              CustomTextField(
                hintText: 'First Name',
                labelText: 'First Name',
                controller: _firstNameController,
                validator: (value)=> Validator.validateEmptyText(value, null),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'Last Name',
                labelText: 'Last Name',
                controller: _lastNameController,
                validator: (value)=> Validator.validateEmptyText(value, null),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                hintText: 'Email',
                labelText: 'Email',
                inputType: TextInputType.emailAddress,
                validator: (value)=> Validator.validateEmail(value),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Password',
                labelText: 'Password',
                isPassword: true,
                inputAction: TextInputAction.done,
                validator: (value)=> Validator.validatePassword(value, null),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                labelText: 'Confirm Password',
                isPassword: true,
                inputAction: TextInputAction.done,
                validator: (value)=> Validator.validateConfirmPassword(value, _passwordController.text),
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () {
                  if(_formKey.currentState != null && _formKey.currentState!.validate()){
                    context.pop();
                  }
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
      ),
    );
  }
}
