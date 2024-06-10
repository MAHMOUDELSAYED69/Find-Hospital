import 'package:find_hospital/bloc/hospital/find_hospital_cubit.dart';
import 'package:find_hospital/core/helper/scaffold_snackbar.dart';
import 'package:find_hospital/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  void _copyText(String? text) {
    Clipboard.setData(ClipboardData(text: text!));
    customSnackBar(context, "Text copied to clipboard");
  }

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
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
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
                          _isHospitalOpen(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _isHospitalOpen() == "Open Now!"
                                ? Colors.green
                                : ColorManager.red,
                          ),
                        ),
                        const Divider(height: 25),
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
                                  style: TextStyle(
                                    color: _ratingChecker(false),
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
                                  style:  TextStyle(
                                    color: _ratingChecker(true),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Business Status',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${widget.hospital?.businessStatus}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                        const Divider(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                              child: Text(
                                'Coordinates',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "lat: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SelectableText(
                                      '${widget.hospital?.lat}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                    IconButton(
                                        onPressed: () => _copyText(
                                            widget.hospital?.lat.toString()),
                                        icon: const Icon(
                                          Icons.copy,
                                          size: 20,
                                        ))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "lng: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SelectableText(
                                          '${widget.hospital?.lng}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        ),
                                        IconButton(
                                            onPressed: () => _copyText(widget
                                                .hospital?.lng
                                                .toString()),
                                            icon: const Icon(
                                              Icons.copy,
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 25),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Place Id',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                '${widget.hospital?.placeId}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                            IconButton(
                                onPressed: () => _copyText(
                                    widget.hospital?.placeId.toString()),
                                icon: const Icon(
                                  Icons.copy,
                                  size: 20,
                                ))
                          ],
                        ),
                        const Divider(height: 25),
                        CustomButton(
                          bgColor: ColorManager.red,
                          iconData: Icons.map_sharp,
                          title: "Open Google Maps",
                          isLoading: _isloading,
                          onPressed: () {
                            cubit.openMaps(
                                lat: widget.hospital?.lat,
                                lng: widget.hospital?.lng);
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            CustomButton(
              title: "Get Nearest Hospital",
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }

  String _isHospitalOpen() {
    return widget.hospital?.openNow == true ? "Open Now!" : "Close Now!";
  }

  Color _ratingChecker(bool total) {
    if (widget.hospital?.rating != null && total == false) {
      return widget.hospital!.rating!.toDouble() > 2.5
          ? Colors.green
          : ColorManager.red;
    }
    if (widget.hospital?.userRatingsTotal != null && total == true) {
      return widget.hospital!.userRatingsTotal!.toInt() > 10
          ? Colors.green
          : ColorManager.red;
    }
    return Colors.red;
  }
}
