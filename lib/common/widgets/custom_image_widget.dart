import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final bool isNotification;
  final String? placeholder;
  const CustomImage({super.key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.isNotification = false, this.placeholder});

  @override
  Widget build(BuildContext context) {

    return CachedNetworkImage(
      imageUrl: image, height: height, width: width, fit: fit,
      placeholder: (context, url) => FlutterLogo(),
      errorWidget: (context, url, error) => FlutterLogo(),
      // placeholder: (context, url) => Image.asset(placeholder ?? Images.loadingLogo, height: height, width: width, fit: fit),
      // errorWidget: (context, url, error) => Image.asset(placeholder ?? Images.loadingLogo, height: height, width: width, fit: fit),
    );
  }
}

