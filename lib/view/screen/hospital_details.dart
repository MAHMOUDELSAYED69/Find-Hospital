import 'package:find_hospital/bloc/hospital/find_hospital_cubit.dart';
import 'package:find_hospital/core/helper/extentions.dart';
import 'package:find_hospital/core/helper/scaffold_snackbar.dart';
import 'package:find_hospital/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final cubit = context.bloc<FindHospitalCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hospital Info"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocConsumer<FindHospitalCubit, FindHospitalState>(
              listener: (context, state) {
                if (state is OpenMapsLoading) {
                  _isloading = true;
                }
                if (state is OpenMapsSuccess) {
                  _isloading = false;
                }
                if (state is OpenMapsFailure) {
                  _isloading = false;
                  customSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
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
                      Divider(height: 25.h),
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
                      Divider(height: 25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Business Status',
                            style: context.textTheme.bodyMedium,
                          ),
                          Text(
                            '${widget.hospital?.businessStatus}',
                            style: context.textTheme.bodyMedium
                                ?.copyWith(color: ColorManager.green),
                          ),
                        ],
                      ),
                      Divider(height: 25.h),
                      Row(
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
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SelectableText(
                                    '${widget.hospital?.lat}',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: ColorManager.green),
                                  ),
                                  IconButton(
                                      onPressed: () => _copyText(
                                          widget.hospital?.lat.toString()),
                                      icon: Icon(
                                        Icons.copy,
                                        size: 20.spMin,
                                      ))
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
                                      SelectableText(
                                        '${widget.hospital?.lng}',
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: ColorManager.green),
                                      ),
                                      IconButton(
                                          onPressed: () => _copyText(
                                              widget.hospital?.lng.toString()),
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
                      Divider(height: 25.h),
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
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: ColorManager.green),
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
                      Divider(height: 30.h),
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
                        height: 50.h,
                      ),
                      CustomButton(
                        title: "Get Nearest Hospital",
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
