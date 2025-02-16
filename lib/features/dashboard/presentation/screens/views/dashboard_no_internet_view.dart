import 'package:flutter/material.dart';

class DashboardNoInternetView extends StatelessWidget {
  const DashboardNoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Spacer(),
        Icon(
          Icons.wifi_off_outlined,
          color: Colors.blueGrey,
          size: 150,
        ),
        SizedBox(
          height: 32,
        ),
        Text(
          'No Internet Connection',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.redAccent,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 8,
          ),
          child: Text(
            'Make sure wifi or cellular data is turned on and go back and try again',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
