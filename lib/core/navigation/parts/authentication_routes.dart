part of '../router.dart';

List<GoRoute> _authenticationRoutes() {
  return [
    GoRoute(
      path: Routes.login,
      name: Routes.login,
      pageBuilder: (context, state) {
        return const MaterialPage(child: LoginScreen());
      },
      routes: [
        GoRoute(
          path: Routes.registration,
          name: Routes.registration,
          pageBuilder: (context, state) => const MaterialPage(
            child: RegistrationScreen(),
          ),
        ),
      ],
    ),
  ];
}
