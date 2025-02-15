import 'package:bloc_ecommerce/core/navigation/router.dart';
import 'package:bloc_ecommerce/core/theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showCustomSnackBar(String? message, {bool isError = true, bool getXSnackBar = false}) {
  if(message != null && message.isNotEmpty) {
    ScaffoldMessenger.of(rootNavigatorKey.currentContext!).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.endToStart,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      content: CustomToast(text: message, isError: isError),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ));
  }
}

class CustomToast extends StatelessWidget {
  final String text;
  final bool isError;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;

  const CustomToast({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.borderRadius = 30,
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 10), required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF334257),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: padding,
            margin: EdgeInsets.only(
              right: Dimensions.paddingSizeLarge,
              left: Dimensions.paddingSizeLarge,
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                isError ? CupertinoIcons.multiply_circle_fill : Icons.check_circle,
                color: isError ? const Color(0xffFF9090).withValues(alpha: 0.5)
                    : const Color(0xff039D55),
                size: 20,
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Flexible(child: Text(
                text, style: fontRegular.copyWith(color: textColor),
                maxLines: 3, overflow: TextOverflow.ellipsis,
              )),
            ]),
          ),
        ),
      ),
    );
  }
}