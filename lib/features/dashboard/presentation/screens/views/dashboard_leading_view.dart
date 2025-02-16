import 'package:flutter/material.dart';

class DashboardLeadingView extends StatelessWidget {
  const DashboardLeadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new_outlined,
        color: Colors.black87,
      ),
    );
  }
}
