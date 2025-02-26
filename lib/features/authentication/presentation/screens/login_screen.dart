import 'package:bloc_ecommerce/common/widgets/custom_snackbar_widget.dart';
import 'package:bloc_ecommerce/common/widgets/custom_textfield_widget.dart';
import 'package:bloc_ecommerce/core/extentions/go_router_extention.dart';
import 'package:bloc_ecommerce/core/extra/validator.dart';
import 'package:bloc_ecommerce/core/navigation/routes.dart';
import 'package:bloc_ecommerce/core/theme/style.dart';
import 'package:bloc_ecommerce/features/authentication/presentation/business_logic/authentication_bloc/authentication_bloc.dart';
import 'package:bloc_ecommerce/features/authentication/presentation/business_logic/authentication_cubit/authentication_cubit.dart';
import 'package:bloc_ecommerce/features/authentication/presentation/widget/link_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/cached/preferences.dart';
import '../../../../core/cached/preferences_key.dart';
import '../../../../core/di/dependency_injection.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final prefs = sl<Preferences>();
    _emailController = TextEditingController(text: prefs.getStringValue(keyName: PreferencesKey.kUserEmail));
    _passwordController = TextEditingController(text: prefs.getStringValue(keyName: PreferencesKey.kUserPass));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    sl<AuthenticationBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 100,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FlutterLogo(size: 200),
                    const SizedBox(height: 80),

                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      labelText: 'Email',
                      inputType: TextInputType.emailAddress,
                      validator: (value)=> Validator.validateEmail(value),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      labelText: 'Password',
                      isPassword: true,
                      inputAction: TextInputAction.done,
                      validator: (value)=> Validator.validatePassword(value, null),
                    ),

                    Row(
                      children: [
                        BlocBuilder<AuthenticationCubit, AuthenticationCubitState>(
                          builder: (context, state) {
                            return Checkbox(
                              value: context.read<AuthenticationCubit>().isRememberMeChecked,
                              onChanged: (value) {
                                context.read<AuthenticationCubit>().toggleRememberMe(value ?? false);
                              },
                            );
                          },
                        ),
                        Text('Remember me'),
                        Spacer(),

                        Transform.translate(
                          offset: const Offset(10, 0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                context.pushNamed(Routes.registration);
                              },
                              child: const Text('Forgot password'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    BlocConsumer<AuthenticationBloc, AuthenticationState>(
                      listenWhen: (previous, current) {
                        return current is AuthenticationLoginSuccess || current is AuthenticationFailure || current is AuthenticationNoInternet;
                      },
                      listener: (context, state) {
                        if (state is AuthenticationLoginSuccess) {
                          context.pushNamedAndRemoveUntil(Routes.homeTab);
                        } else if (state is AuthenticationFailure) {
                          showCustomSnackBar(state.message);
                        }else if (state is AuthenticationNoInternet) {
                          showCustomSnackBar('No internet connection');
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthenticationLoading) {
                          return const CircularProgressIndicator();
                        }
                        return FilledButton(
                          onPressed: () {
                            if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                              context.read<AuthenticationBloc>().add(LoginRequested(
                                email: _emailController.text.trim(), password: _passwordController.text.trim(),
                                isRememberMeChecked: context.read<AuthenticationCubit>().isRememberMeChecked,
                              ));
                            }
                          },
                          child: const Text('Login'),
                        );
                      },
                    ),

                    LinkText(
                      text: 'Don\'t have an account? ',
                      linkText: 'Sign up',
                      onTap: () {
                        context.pushNamed(Routes.registration);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
