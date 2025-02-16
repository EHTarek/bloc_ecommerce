import 'package:flutter/material.dart';

class DashboardTitleView extends StatelessWidget {
  const DashboardTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppBar().preferredSize.height - 16,
      // child: const Image(
      //   image: AssetImage(
      //     'assets/images/app_logo.png',
      //   ),
      //   fit: BoxFit.fitHeight,
      // ),
    );
  }
}
