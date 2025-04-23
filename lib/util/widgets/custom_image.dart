import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.url,  this.height,  this.width,  this.child});

  final String url;
  final double? height;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {

    bool isNetworkImage = url.startsWith("http") || url.startsWith("https");
    return isNetworkImage ? Image(
        image: Image.network(url).image,
        fit: BoxFit.cover ,
        alignment: Alignment.topCenter,
        height: height,
        width: width,
        loadingBuilder: (context, child, loadingProgress) {
          if(loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded/loadingProgress.expectedTotalBytes! : null,
            ),
          );
        },
        errorBuilder: (context, exception, stackTrace) {
          return Image(
            image: Image.asset("assets/image_not_found.png").image,
            height: height,
            width: width,
            fit: BoxFit.cover,
          );
        }

    ) : Image(
      image: Image.asset("assets/default_pic.png").image,
      height: height,
      width: width,
      fit: BoxFit.cover,
    ) ;
  }
}

