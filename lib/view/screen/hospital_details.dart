import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_hospital/bloc/hospital_cubit/find_hospital_cubit.dart';
import 'package:find_hospital/core/helper/extentions.dart';
import 'package:find_hospital/core/helper/scaffold_snackbar.dart';
import 'package:find_hospital/view/widget/custom_button.dart';
import 'package:find_hospital/view/widget/place_photo.dart';
import '../../data/models/hospital_model.dart';
import '../widget/hospital_info_title.dart';
import '../widget/hospital_rating.dart';

class HospitalDetailScreen extends StatefulWidget {
  const HospitalDetailScreen({super.key, this.hospital});
  final HospitalsPlaceInfo? hospital;

  @override
  State<HospitalDetailScreen> createState() => _HospitalDetailScreenState();
}

class _HospitalDetailScreenState extends State<HospitalDetailScreen> {
  //?---------------------------------------- Copy Text Method
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
                  final hospital = widget.hospital;
                  return Column(
                    children: [
                      SizedBox(height: 8.h),
                      //?----------------------------------- Hospital Name and isOpen?
                      HospitalInfoTitle(
                        name: hospital?.name,
                        isOpen: hospital?.openNow,
                      ),
                      Divider(height: 20.h),
                      //?--------------------------------------- Rating and user Total Rating
                      HospitalRateCard(
                        rating: hospital?.rating,
                        userTotalRating: hospital?.userRatingsTotal,
                      ),
                      Divider(height: 20.h),
                      //?------------------------------------------- Business Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Business Status',
                            style: context.textTheme.bodyMedium,
                          ),
                          Text(
                            '${hospital?.businessStatus}',
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                      Divider(height: 20.h),
                      //?--------------------------------------------- Distance
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Distance',
                            style: context.textTheme.bodyMedium,
                          ),
                          Text(
                            '${hospital?.distance}',
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                      Divider(height: 20.h),
                      //?--------------------------------------------- Duration with Car
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Duration(car)',
                            style: context.textTheme.bodyMedium,
                          ),
                          Text(
                            '${hospital?.duration}',
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                      if (hospital!.internationalPhoneNumber!.isNotEmpty)
                        Divider(height: 20.h),
                      if (hospital.internationalPhoneNumber!.isNotEmpty)
                        //?--------------------------------------------- Phone Number
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone Number',
                              style: context.textTheme.bodyMedium,
                            ),
                            const Spacer(),
                            Text(
                              '${hospital.internationalPhoneNumber}',
                              style: context.textTheme.labelMedium,
                            ),
                            //?-------------------------------------- Copy Number Icon Button
                            IconButton(
                              onPressed: () => _copyText(
                                  hospital.internationalPhoneNumber.toString()),
                              icon: Icon(
                                Icons.copy,
                                size: 20.spMin,
                              ),
                            ),
                          ],
                        ),
                      if (hospital.photos != null &&
                          hospital.photos!.isNotEmpty)
                        Divider(height: 20.h),
                      if (hospital.photos != null &&
                          hospital.photos!.isNotEmpty)
                        //?---------------------------------------------- Images Card
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Images',
                              style: context.textTheme.bodyMedium,
                            ),
                            PlacePhotoWidget(photoList: hospital.photos)
                          ],
                        ),
                      Divider(height: 20.h),
                      //?---------------------------------------------- Place Id
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
                              hospital.placeId,
                              style: context.textTheme.labelMedium,
                            ),
                          ),
                          //?------------------------------------- Copy Place Id Icon Button
                          IconButton(
                              onPressed: () =>
                                  _copyText(hospital.placeId.toString()),
                              icon: Icon(
                                Icons.copy,
                                size: 20.spMin,
                              ))
                        ],
                      ),
                      Divider(height: 25.h),
                      //?-------------------------------------- Open In Maps Button
                      CustomButton(
                        iconData: Icons.map_sharp,
                        title: "Open In Google Maps",
                        isLoading: _isloading,
                        onPressed: () => cubit.openMaps(
                            lat: hospital.lat, lng: hospital.lng),
                      ),
                      Divider(height: 25.h),
                      //?---------------------------------------- Find Hospital Back Button
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
