part of '../router.dart';

List<GoRoute> _onboardingRoutes() {
  return [
    GoRoute(
      path: Routes.splash,
      name: Routes.splash,
      pageBuilder: (context, state) {
        return const MaterialPage(child: SplashScreen());
      },
    ),
    GoRoute(
      path: Routes.onboarding,
      name: Routes.onboarding,
      pageBuilder: (context, state) {
        return const MaterialPage(child: OnboardingScreen());
      },
    ),
  ];
}
