import 'package:bloc_ecommerce/core/extentions/go_router_extention.dart';
import 'package:bloc_ecommerce/core/navigation/routes.dart';
import 'package:bloc_ecommerce/features/authentication/presentation/business_logic/authentication_bloc/authentication_bloc.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/business_logic/cart_cubit/cart_cubit.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/widgets/checkout_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardDrawerWidget extends StatelessWidget {
  const DashboardDrawerWidget({super.key});

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
                  ListTile(
                    title: const Text('Cart'),
                    leading: const Icon(Icons.add_shopping_cart),
                    onTap: () {
                      context.pop();
                      showDialog(context: context, builder: (context) => const CheckoutDialogWidget());
                    },
                  ),
                  Spacer(),

                  ListTile(
                    tileColor: Colors.red, iconColor: Colors.white, textColor: Colors.white,
                    title: const Text('Logout'),
                    leading: const Icon(Icons.logout),
                    onTap: () {
                      context.pushNamedAndRemoveUntil(Routes.login);
                      context.read<AuthenticationBloc>().add(LogoutRequested());
                      context.read<CartCubit>().clearCart();
                    },
                  ),
                ],
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
