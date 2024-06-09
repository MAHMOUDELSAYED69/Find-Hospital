import 'package:find_hospital/bloc/hospital/find_hospital_cubit.dart';
import 'package:find_hospital/core/helper/scaffold_snackbar.dart';
import 'package:find_hospital/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
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
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: 500,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              widget.hospital?.name ?? 'Unknown Hospital',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isHospitalOpen(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isHospitalOpen() == "Hospital Open Now!"
                    ? Colors.green
                    : ColorManager.red,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      "Rating",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.hospital?.rating.toString() ?? "N/A",
                      style: const TextStyle(
                        color: ColorManager.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Users Ratings Total",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.hospital?.userRatingsTotal ?? 0} Users',
                      style: const TextStyle(
                        color: ColorManager.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
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
