import 'package:bloc_ecommerce/core/extentions/go_router_extention.dart';
import 'package:bloc_ecommerce/core/navigation/routes.dart';
import 'package:bloc_ecommerce/features/authentication/presentation/business_logic/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardDrawerView extends StatelessWidget {
  const DashboardDrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) {
            if (authState is AuthenticationUserDataLoaded) {
              return Column(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(authState.loginResponse.data?.name ?? ''),
                    accountEmail: Text(authState.loginResponse.data?.email ?? ''),
                    currentAccountPicture: FlutterLogo(size: 150),
                  ),
                  ListTile(
                    title: const Text('Home'),
                    leading: const Icon(Icons.home),
                    onTap: () => context.pop(),
                  ),
                  Spacer(),

                  ListTile(
                    tileColor: Colors.red, iconColor: Colors.white, textColor: Colors.white,
                    title: const Text('Logout'),
                    leading: const Icon(Icons.logout),
                    onTap: () {
                      context.read<AuthenticationBloc>().add(LogoutRequested());
                      context.pushNamedAndRemoveUntil(Routes.login);
                    },
                  ),
                ],
              );
            }
            return ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () {
                context.read<AuthenticationBloc>().add(LogoutRequested());
                context.pushNamedAndRemoveUntil(Routes.login);
              },
            );
            return SizedBox();
          },
        ),
      ),
    );
  }
}
