# bloc_ecommerce

E-Commerce app with Flutter BloC and DDD


```

 lib
  ├─ app_config.dart
  ├─ common
  │  └─ widgets
  │     ├─ code_picker_widget.dart
  │     ├─ custom_image_widget.dart
  │     ├─ custom_snackbar_widget.dart
  │     └─ custom_textfield_widget.dart
  ├─ core
  │  ├─ api
  │  │  ├─ api_checker.dart
  │  │  ├─ api_client.dart
  │  │  └─ api_endpoints.dart
  │  ├─ base
  │  │  ├─ empty_param.dart
  │  │  ├─ repository.dart
  │  │  ├─ response_model.dart
  │  │  └─ use_case.dart
  │  ├─ cached
  │  │  ├─ preferences.dart
  │  │  └─ preferences_key.dart
  │  ├─ di
  │  │  ├─ dependency_injection.dart
  │  │  └─ parts
  │  │     ├─ blocs.dart
  │  │     ├─ core.dart
  │  │     ├─ data_sources.dart
  │  │     ├─ externals.dart
  │  │     ├─ repositories.dart
  │  │     ├─ services.dart
  │  │     └─ use_cases.dart
  │  ├─ error
  │  │  ├─ exception.dart
  │  │  └─ failure.dart
  │  ├─ extentions
  │  │  └─ go_router_extention.dart
  │  ├─ extra
  │  │  ├─ app_observer.dart
  │  │  ├─ enums.dart
  │  │  ├─ log.dart
  │  │  ├─ network_info.dart
  │  │  ├─ token_service.dart
  │  │  └─ validator.dart
  │  ├─ navigation
  │  │  ├─ parts
  │  │  │  ├─ authentication_routes.dart
  │  │  │  ├─ dashboard_routes.dart
  │  │  │  └─ on_boarding_routes.dart
  │  │  ├─ router.dart
  │  │  └─ routes.dart
  │  └─ theme
  │     ├─ app_theme.dart
  │     ├─ src
  │     │  ├─ part
  │     │  │  ├─ app_bar_theme.dart
  │     │  │  ├─ bottom_navigation_bar_theme_data.dart
  │     │  │  ├─ button_theme_data.dart
  │     │  │  ├─ dropdown_menu_theme_data.dart
  │     │  │  └─ input_decoration_theme.dart
  │     │  ├─ theme_data.dart
  │     │  └─ theme_extensions
  │     │     ├─ extensions.dart
  │     │     └─ src
  │     │        ├─ colors.dart
  │     │        └─ text_style.dart
  │     ├─ style.dart
  │     └─ theme.dart
  ├─ features
  │  ├─ authentication
  │  │  ├─ data
  │  │  │  ├─ data_source
  │  │  │  │  ├─ authentication_local_data_source.dart
  │  │  │  │  └─ authentication_remote_data_source.dart
  │  │  │  ├─ model
  │  │  │  │  ├─ login_model.dart
  │  │  │  │  └─ sign_up_model.dart
  │  │  │  └─ repository
  │  │  │     └─ authentication_repository_impl.dart
  │  │  ├─ domain
  │  │  │  ├─ entity
  │  │  │  │  ├─ login_entity.dart
  │  │  │  │  └─ sign_up_entity.dart
  │  │  │  ├─ repository
  │  │  │  │  └─ authentication_repository.dart
  │  │  │  └─ use_case
  │  │  │     ├─ authentication_use_case.dart
  │  │  │     └─ user_usecase.dart
  │  │  └─ presentation
  │  │     ├─ business_logic
  │  │     │  ├─ authentication_bloc
  │  │     │  │  ├─ authentication_bloc.dart
  │  │     │  │  ├─ authentication_event.dart
  │  │     │  │  └─ authentication_state.dart
  │  │     │  └─ authentication_cubit
  │  │     │     ├─ authentication_cubit.dart
  │  │     │     └─ authentication_state.dart
  │  │     ├─ screens
  │  │     │  ├─ login_screen.dart
  │  │     │  └─ registration_screen.dart
  │  │     └─ widget
  │  │        └─ link_text_widget.dart
  │  ├─ dashboard
  │  │  ├─ data
  │  │  │  ├─ data_source
  │  │  │  │  ├─ dashboard_local_data_source.dart
  │  │  │  │  └─ dashboard_remote_data_source.dart
  │  │  │  ├─ models
  │  │  │  │  ├─ cart_products_model.dart
  │  │  │  │  └─ products_model.dart
  │  │  │  └─ repositories
  │  │  │     └─ dashboard_repository_impl.dart
  │  │  ├─ domain
  │  │  │  ├─ entities
  │  │  │  │  ├─ cart_products_entity.dart
  │  │  │  │  └─ products_entity.dart
  │  │  │  ├─ repositories
  │  │  │  │  └─ dashboard_repository.dart
  │  │  │  └─ use_cases
  │  │  │     ├─ cart_usecase.dart
  │  │  │     └─ products_usecase.dart
  │  │  └─ presentation
  │  │     ├─ business_logic
  │  │     │  ├─ all_products_bloc
  │  │     │  │  ├─ all_products_bloc.dart
  │  │     │  │  ├─ all_products_event.dart
  │  │     │  │  └─ all_products_state.dart
  │  │     │  └─ cart_cubit
  │  │     │     ├─ cart_cubit.dart
  │  │     │     └─ cart_state.dart
  │  │     ├─ screens
  │  │     │  └─ dashboard_screen.dart
  │  │     └─ widgets
  │  │        ├─ checkout_dialog_widget.dart
  │  │        ├─ dashboard_drawer_widget.dart
  │  │        ├─ product_widget.dart
  │  │        └─ quantity_button_widget.dart
  │  └─ on_boarding
  │     └─ presentation
  │        ├─ business_logic
  │        │  └─ splash_bloc
  │        │     ├─ splash_bloc.dart
  │        │     ├─ splash_event.dart
  │        │     └─ splash_state.dart
  │        └─ screens
  │           └─ splash_screen.dart
  └─ main.dart

```