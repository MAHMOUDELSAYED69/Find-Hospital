import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_hospital/bloc/hospital_cubit/find_hospital_cubit.dart';
import 'package:find_hospital/core/helper/extentions.dart';
import 'package:find_hospital/core/helper/scaffold_snackbar.dart';
import 'package:find_hospital/view/widget/custom_button.dart';
import 'package:find_hospital/view/widget/place_photo.dart';
import '../../core/constant/color.dart';
import '../../data/models/hospital_model.dart';

class HospitalDetailScreen extends StatefulWidget {
  const HospitalDetailScreen({super.key, this.hospital});
  final PlaceInfo? hospital;

  @override
  State<HospitalDetailScreen> createState() => _HospitalDetailScreenState();
}

class _HospitalDetailScreenState extends State<HospitalDetailScreen> {
  void _copyText(String? text) {
    Clipboard.setData(ClipboardData(text: text!));
    customSnackBar(context, "Text copied to clipboard");
  }

  bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FindHospitalCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hospital Info"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocConsumer<FindHospitalCubit, FindHospitalState>(
                listener: (context, state) {
                  if (state is OpenMapsLoading) {
                    setState(() {
                      _isloading = true;
                    });
                  }
                  if (state is OpenMapsSuccess) {
                    setState(() {
                      _isloading = false;
                    });
                  }
                  if (state is OpenMapsFailure) {
                    setState(() {
                      _isloading = false;
                    });
                    customSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      SizedBox(height: 8.h),
                      Text(
                        widget.hospital?.name ?? 'Unknown Hospital',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyLarge
                            ?.copyWith(fontSize: 20.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        cubit.isHospitalOpen(widget.hospital?.openNow),
                        style: context.textTheme.bodyLarge?.copyWith(
                          color:
                              cubit.isHospitalOpen(widget.hospital?.openNow) ==
                                      "Open Now!"
                                  ? Colors.green
                                  : ColorManager.red,
                        ),
                      ),
                      Divider(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Rating",
                                style: context.textTheme.bodyMedium,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                widget.hospital?.rating.toString() ?? "N/A",
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: cubit.ratingChecker(
                                      rating: widget.hospital?.rating),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Users Ratings Total",
                                style: context.textTheme.bodyMedium,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '${widget.hospital?.userRatingsTotal ?? 0} Users',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: cubit.ratingChecker(
                                      totalRating:
                                          widget.hospital?.userRatingsTotal),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Business Status',
                            style: context.textTheme.bodyMedium,
                          ),
                          Text(
                            '${widget.hospital?.businessStatus}',
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                      Divider(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone Numbers',
                            style: context.textTheme.bodyMedium,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${widget.hospital?.formattedPhoneNumber}',
                                    style: context.textTheme.labelMedium,
                                  ),
                                  IconButton(
                                    onPressed: () => _copyText(widget
                                        .hospital?.formattedPhoneNumber
                                        .toString()),
                                    icon: Icon(
                                      Icons.copy,
                                      size: 20.spMin,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  Text(
                                    '${widget.hospital?.internationalPhoneNumber}',
                                    style: context.textTheme.labelMedium,
                                  ),
                                  IconButton(
                                    onPressed: () => _copyText(widget
                                        .hospital?.internationalPhoneNumber
                                        .toString()),
                                    icon: Icon(
                                      Icons.copy,
                                      size: 20.spMin,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (widget.hospital?.photos != null)
                        Divider(height: 20.h),
                      if (widget.hospital?.photos != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Image',
                              style: context.textTheme.bodyMedium,
                            ),
                            PlacePhotoWidget(placeInfo: widget.hospital!)
                          ],
                        ),
                      Offstage(
                        offstage: true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                'Coordinates',
                                style: context.textTheme.bodyMedium,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "lat: ",
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${widget.hospital?.lat}',
                                      style: context.textTheme.labelMedium,
                                    ),
                                    IconButton(
                                      onPressed: () => _copyText(
                                          widget.hospital?.lat.toString()),
                                      icon: Icon(
                                        Icons.copy,
                                        size: 20.spMin,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "lng: ",
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${widget.hospital?.lng}',
                                          style: context.textTheme.labelMedium,
                                        ),
                                        IconButton(
                                            onPressed: () => _copyText(widget
                                                .hospital?.lng
                                                .toString()),
                                            icon: Icon(
                                              Icons.copy,
                                              size: 20.spMin,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Place Id',
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              '${widget.hospital?.placeId}',
                              style: context.textTheme.labelMedium,
                            ),
                          ),
                          IconButton(
                              onPressed: () => _copyText(
                                  widget.hospital?.placeId.toString()),
                              icon: Icon(
                                Icons.copy,
                                size: 20.spMin,
                              ))
                        ],
                      ),
                      Divider(height: 25.h),
                      CustomButton(
                        iconData: Icons.map_sharp,
                        title: "Open In Google Maps",
                        isLoading: _isloading,
                        onPressed: () {
                          cubit.openMaps(
                              lat: widget.hospital?.lat,
                              lng: widget.hospital?.lng);
                        },
                      ),
                      Divider(
                        height: 25.h,
                      ),
                      CustomButton(
                        width: context.width / 1.8,
                        title: "Find Hospital",
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
