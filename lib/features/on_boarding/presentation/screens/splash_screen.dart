import 'package:bloc_ecommerce/core/navigation/routes.dart';
import 'package:bloc_ecommerce/core/cached/preferences.dart';
import 'package:bloc_ecommerce/core/cached/preferences_key.dart';
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
            getOnboardingStatus();
          }
        },
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(
            color: Colors.black54,
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
              const SizedBox(height: 20),
              // const Text(appName),
            ],
          ),
        ),
      ),
    );
  }

  void getOnboardingStatus() async {
    final prefs = sl<Preferences>();
    final isViewed = prefs.getBoolValue(keyName: PreferencesKey.kOnboardingStatus);
    if (!isViewed) {
      navigateToOnboarding();
    } else {
      navigateToDashboard();
    }
  }

  void navigateToOnboarding() {
    context.pushReplacementNamed(Routes.onboarding);
  }

  void navigateToDashboard() {
    // context.pushReplacementNamed(Routes.homeTab);
    context.pushReplacementNamed(Routes.login);
  }
}
