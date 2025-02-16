import 'package:bloc_ecommerce/common/widgets/custom_snackbar_widget.dart';
import 'package:bloc_ecommerce/common/widgets/custom_textfield_widget.dart';
import 'package:bloc_ecommerce/core/di/dependency_injection.dart';
import 'package:bloc_ecommerce/core/extentions/go_router_extention.dart';
import 'package:bloc_ecommerce/core/navigation/routes.dart';
import 'package:bloc_ecommerce/core/theme/style.dart';
import 'package:bloc_ecommerce/features/authentication/presentation/business_logic/authentication_bloc/authentication_bloc.dart';
import 'package:bloc_ecommerce/features/dashboard/domain/entities/products_entity.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/business_logic/all_products_bloc/all_products_bloc.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/business_logic/cart_cubit/cart_cubit.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/screens/views/dashboard_drawer_view.dart';
import 'package:bloc_ecommerce/features/dashboard/presentation/widgets/product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<AllProductsBloc>().add(GetAllProductsEvent());
    context.read<AuthenticationBloc>().add(GetLoggedInUserData());
  }

  @override
  void dispose() {
    _searchController.dispose();
    sl<AllProductsBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DashboardDrawerView(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AllProductsBloc>().add(GetAllProductsEvent());
        },
        child: Stack(children: [
          CustomScrollView(slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              title: CustomTextField(
                controller: _searchController,
                hintText: 'Rice, Oil, etc...',
                labelText: 'Search',
                showLabelText: false,
                prefixIcon: CupertinoIcons.search,
                onChanged: (_) {
                  if (_searchController.text.isNotEmpty) {
                    context.read<AllProductsBloc>().add(SearchProductsEvent(query: _searchController.text));
                  }
                },
                onSubmit: (_) {
                  if (_searchController.text.isNotEmpty) {
                    context.read<AllProductsBloc>().add(SearchProductsEvent(query: _searchController.text));
                  }
                },
              ),
            ),

            BlocConsumer<AllProductsBloc, AllProductsState>(
              listenWhen: (previous, current) => current is AllProductsError
                  || current is AllProductsSessionOut || current is AllProductsNoInternet,
              listener: (context, state) {
                if (state is AllProductsError || state is AllProductsSessionOut) {
                  context.pushNamedAndRemoveUntil(Routes.login);
                } else if (state is AllProductsNoInternet) {
                  showCustomSnackBar('No Internet Connection');
                }
              },
              builder: (context, state) {
                if (state is AllProductsLoaded || state is SearchProductLoaded) {
                  List<ProductsEntity> products = [];
                  if (state is AllProductsLoaded) {
                    products = state.products;
                  } else if (state is SearchProductLoaded) {
                    products = state.products;
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: index +1 == products.length ? 100 : 0),
                        child: ProductWidget(product: products[index]),
                      ),
                      childCount: products.length,
                    ),
                  );
                }
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),

          ]),

          BlocBuilder<CartCubit, CartState>(
            buildWhen: (previous, current) => current is CartUpdated,
            builder: (context, state) {
              double totalAmount = 0;
              if(state is CartUpdated) {

                for (var element in state.cart) {
                  double price = double.tryParse(element.product?.price ?? '0') ?? 0;
                  totalAmount += price * (element.quantity ?? 1);
                }

                return totalAmount > 0 ? Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.8),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radiusLarge),
                        topRight: Radius.circular(Dimensions.radiusLarge),
                      ),
                    ),
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: Column(children: [
                      Text(
                        'Total : \$${totalAmount.toStringAsFixed(2)}',
                        style: fontMedium.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Checkout', style: fontMedium),
                      ),
                    ]),
                  ),
                ) : const SizedBox();
              }
              return const SizedBox();
            },
          ),

        ]),
      ),
    );
  }
}
