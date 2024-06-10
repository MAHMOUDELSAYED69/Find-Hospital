import 'package:find_hospital/bloc/hospital/find_hospital_cubit.dart';
import 'package:find_hospital/core/constant/color.dart';
import 'package:find_hospital/core/constant/routes.dart';
import 'package:find_hospital/core/helper/scaffold_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../core/constant/animation.dart';
import '../../data/models/hospital_model.dart';
import '../widget/custom_button.dart';
import '../widget/custom_dropdown.dart';

class FindHospitalScreen extends StatefulWidget {
  const FindHospitalScreen({super.key});

  @override
  State<FindHospitalScreen> createState() => _FindHospitalScreenState();
}

class _FindHospitalScreenState extends State<FindHospitalScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FindHospitalCubit>(context).getCurrentLocation(context);
  }

  bool _isLoading = false;
  List<PlaceInfo?> _hospitalList = [];
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FindHospitalCubit>(context);
    return Scaffold(
      appBar: AppBar(
          foregroundColor: ColorManager.black,
          backgroundColor: ColorManager.red,
          title: const Text(
            "Find Hospital Screen",
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
          )),
      endDrawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.red,
        onPressed: () {
          cubit.getCurrentLocation(context);
          cubit.getNearestHospitals(radius: selectedDoubleValue);
        },
        child: const Icon(
          Icons.location_on,
          color: ColorManager.black,
        ),
      ),
      body: BlocConsumer<FindHospitalCubit, FindHospitalState>(
        listener: (context, state) {
          if (state is FindHospitalLoading) {
            _isLoading = true;
          } else if (state is FindHospitalSuccess) {
            _isLoading = false;
            _hospitalList = state.hospitalsList;
          } else if (state is FindHospitalFailure) {
            _isLoading = false;

            customSnackBar(
                context, 'There was an error! Please try again later.');
          }
        },
        builder: (context, state) {
          return _isLoading
              ? Center(child: _buildLoadingIndicator())
              : Column(
                  children: [
                    _buildTotalHospital(_hospitalList.length),
                    _hospitalList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: _hospitalList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      final PlaceInfo? placeInfo =
                                          _hospitalList[index];
                                      Navigator.pushNamed(
                                          context, RouteManager.details,
                                          arguments: placeInfo);
                                    },
                                    title:
                                        Text(_hospitalList[index]?.name ?? ""),
                                    subtitle: Text(
                                        _hospitalList[index]?.businessStatus ??
                                            ""),
                                    trailing: const Icon(Icons.chevron_right),
                                    leading: const Icon(Icons.healing),
                                  ),
                                );
                              },
                            ),
                          )
                        : const Expanded(
                            child: Icon(
                              Icons.find_replace_rounded,
                              size: 100,
                              color: ColorManager.red,
                            ),
                          ),
                  ],
                );
        },
      ),
    );
  }

  Widget _buildTotalHospital(int totalHospital) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  const Text(
                    "Total hospital Founded: ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    totalHospital.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.red,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(flex: 2, child: MyDropDownMenuButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return LottieBuilder.asset(LottieManager.loading);
  }
}
