import 'package:bloc_ecommerce/app_config.dart';
import 'package:bloc_ecommerce/core/navigation/routes.dart';
import 'package:bloc_ecommerce/core/cached/preferences.dart';
import 'package:bloc_ecommerce/core/cached/preferences_key.dart';
import 'package:bloc_ecommerce/core/theme/style.dart';
import 'package:bloc_ecommerce/core/theme/theme.dart';
import 'package:bloc_ecommerce/features/authentication/presentation/business_logic/authentication_cubit/authentication_cubit.dart';
import 'package:bloc_ecommerce/features/on_boarding/presentation/business_logic/splash_bloc/splash_bloc.dart';
import 'package:bloc_ecommerce/core/di/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final prefs = sl<Preferences>();

  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(SplashEventFetch());
  }

  @override
  void dispose() {
    SplashBloc().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            navigateToDashboard();
          }
        },
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            color: context.color.primary.withValues(alpha: 0.4),
            // image: DecorationImage(
            //   image: AssetImage('assets/images/splash/splash_bg.png'),
            //   fit: BoxFit.cover,
            //   opacity: 0.4,
            // ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assets/images/splash/splash_logo.png'),
              FlutterLogo(size: 200),
              const SizedBox(height: 20),
              Text(AppConfig.appName, style: fontBold.copyWith(
                fontSize: 24,
                color: context.color.primary,
              )),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToDashboard() {
    bool isLoggedIn = sl<AuthenticationCubit>().isUserLoggedIn();
    if(isLoggedIn) {
      context.pushReplacementNamed(Routes.homeTab);
    } else {
      context.pushReplacementNamed(Routes.login);
    }
  }
}
