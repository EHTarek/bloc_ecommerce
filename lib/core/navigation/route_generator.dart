import 'package:bloc_ecommerce/core/navigation/routes.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:bloc_ecommerce/features/on_boarding/presentation/screens/onboarding_screen.dart';
import 'package:bloc_ecommerce/features/on_boarding/presentation/screens/splash_screen.dart';
import 'package:bloc_ecommerce/core/di/dependency_injection.dart';
import 'package:bloc_ecommerce/core/extra/log.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Log log = sl<Log>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    log.verbose(
      title: 'Value Pass In Navigating Screen->',
      msg: args.runtimeType,
    );

    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.homeTab:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      // case Routes.kLoginScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => LoginScreen(
      //       redirectToLogin:
      //       args == null ? RedirectToLogin.non : args as RedirectToLogin,
      //     ),
      //   );
      // case Routes.kSignupScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => SignupScreen(
      //       //this argument for Reuse of Auth screen
      //       //Identify that signup screen, otp Screen and Pin set screen Called for Register or Forget password
      //       // "AuthScreensFor" is a enum and define in constants directory with "register" and "forget password" this two value
      //       authScreensFor: args as AuthScreensFor,
      //     ),
      //   );

      // case Routes.kPlanetVideoPlayerScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const PlanetVideoPlayerView(youTubeController: , title: ),
      //   );

      //Error pages
      default:
        return MaterialPageRoute(builder: (_) => const NavigationErrorScreen());
    }
  }
}

class NavigationErrorScreen extends StatelessWidget {
  const NavigationErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const Center(
        child: Text(
          'Navigation Error\nGo Back and Try Again.',
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.5,
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
