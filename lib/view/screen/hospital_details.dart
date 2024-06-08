import 'dart:developer';

import 'package:find_hospital/bloc/hospital/find_hospital_cubit.dart';
import 'package:find_hospital/core/helper/scaffold_snackbar.dart';
import 'package:find_hospital/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constant/color.dart';
import '../../data/models/hospital_model.dart';

class HospitalDetailScreen extends StatefulWidget {
  const HospitalDetailScreen({super.key, this.hospital});
  final PlaceInfo? hospital;

  @override
  State<HospitalDetailScreen> createState() => _HospitalDetailScreenState();
}

class _HospitalDetailScreenState extends State<HospitalDetailScreen> {
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FindHospitalCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hospital Info"),
        backgroundColor: ColorManager.red,
        titleSpacing: 0,
      ),
      body: Center(
        child: Column(
          children: [
            _buildHospitalInfoCard(),
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
                return CustomButton(
                  iconData: Icons.map_sharp,
                  title: "Open Maps",
                  isLoading: _isloading,
                  onPressed: () {
                    cubit.openMaps(
                        lat: widget.hospital?.lat, lng: widget.hospital?.lng);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Column(
              children: [
                Icon(Icons.favorite_border),
                Icon(
                  Icons.h_mobiledata,
                  size: 35,
                  color: ColorManager.red,
                )
              ],
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.hospital?.name}'),
                  Text(isHospitalOpen()),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text("Rating"),
                  Text(
                    widget.hospital?.rating.toString() ?? "",
                    style: const TextStyle(
                        color: ColorManager.red, fontWeight: FontWeight.bold),
                  ),
                  const Text("Users Ratings Total"),
                  Text(
                    '${widget.hospital?.userRatingsTotal} Users',
                    style: const TextStyle(
                        color: ColorManager.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String isHospitalOpen() {
    return widget.hospital?.openNow == true
        ? "Hospital Open Now!"
        : "Hospital Open Close!";
  }
}
