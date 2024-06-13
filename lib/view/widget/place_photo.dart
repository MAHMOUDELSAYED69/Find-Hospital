import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_hospital/core/helper/extentions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../core/constant/animation.dart';
import '../../data/models/hospital_model.dart';

class PlacePhotoWidget extends StatelessWidget {
  const PlacePhotoWidget({super.key, required this.placeInfo});
  final PlaceInfo placeInfo;
  @override
  Widget build(BuildContext context) {
    if (placeInfo.photos != null && placeInfo.photos!.isNotEmpty) {
      String photoReference = placeInfo.photos![0]['photo_reference'];
      String photoUrl = placeInfo.getPhotoUrl(photoReference);

      return SizedBox(
        width: context.width / 2,
        height: context.width / 3,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: photoUrl,
          placeholder: (context, url) => ColorFiltered(
            colorFilter: ColorFilter.mode(
                context.appBarTheme.backgroundColor!, BlendMode.srcATop),
            child:
                Lottie.asset(LottieManager.loading, frameRate: FrameRate.max),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );
    } else {
      return const Text('No photos available');
    }
  }
}
