import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

const String assetName = 'assets/images/noimage.jpg';

class PersonCacheImage extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  const PersonCacheImage(
      {super.key,
      required this.height,
      required this.width,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      imageBuilder: (context, imageProvider) {
        return _imageWidget(imageProvider);
      },
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) =>
          _imageWidget(const AssetImage(assetName)),
    );
  }

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
        ),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
