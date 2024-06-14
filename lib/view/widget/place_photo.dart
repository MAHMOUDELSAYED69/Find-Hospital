import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_hospital/core/constant/color.dart';
import 'package:find_hospital/core/helper/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../core/constant/animation.dart';
import '../../core/constant/api_url.dart';

class PlacePhotoWidget extends StatefulWidget {
  const PlacePhotoWidget({super.key, required this.photoList});
  final List<Map<String, dynamic>>? photoList;

  @override
  PlacePhotoWidgetState createState() => PlacePhotoWidgetState();
}

class PlacePhotoWidgetState extends State<PlacePhotoWidget> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.photoList!.isNotEmpty && widget.photoList != null) {
      return SizedBox(
        width: context.width / 1.5,
        height: context.height / 3,
        child: Card(
          elevation: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: widget.photoList!.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    String photoReference =
                        widget.photoList![index]['photo_reference'];
                    String photoUrl =
                        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&maxheight=400&photoreference=$photoReference&key=${ApiUrlManager.googleMap}';

                    log(photoUrl);
                    return CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: photoUrl,
                      placeholder: (context, url) => ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            context.appBarTheme.backgroundColor!,
                            BlendMode.srcATop),
                        child: Lottie.asset(LottieManager.loading,
                            frameRate: FrameRate.max),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    );
                  },
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: ColorManager.black.withOpacity(0.54),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      '${_currentPage + 1} / ${widget.photoList!.length}',
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Text('No photos available');
    }
  }
}
