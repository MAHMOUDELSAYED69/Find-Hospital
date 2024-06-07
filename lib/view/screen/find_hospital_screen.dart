import 'dart:developer';

import 'package:find_hospital/bloc/hospital/find_hospital_cubit.dart';
import 'package:find_hospital/core/constant/color.dart';
import 'package:find_hospital/core/constant/routes.dart';
import 'package:find_hospital/core/helper/scaffold_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/hospital_model.dart';
import '../widget/custom_button.dart';

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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          CustomButton(
              title: "Get Nearest Hospital",
              onPressed: () {
                cubit.getCurrentLocation(context);
                cubit.getNearestHospitals(radius: 500);
              }),
          const SizedBox(height: 20),
        ],
      ),
      body: BlocConsumer<FindHospitalCubit, FindHospitalState>(
        listener: (context, state) {
          if (state is FindHospitalLoading) {
            setState(() {
              _isLoading = true;
            });
          } else if (state is FindHospitalSuccess) {
            setState(() {
              _isLoading = false;
              _hospitalList = state.hospitalsList;
            });
          } else if (state is FindHospitalFailure) {
            setState(() {
              _isLoading = false;
            });
            customSnackBar(
                context, 'There was an error! Please try again later.');
          }
        },
        builder: (context, state) {
          return _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _hospitalList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          final PlaceInfo? placeInfo = _hospitalList[index];
                          Navigator.pushNamed(context, RouteManager.details,
                              arguments: placeInfo);
                        },
                        title: Text(_hospitalList[index]?.name ?? ""),
                        subtitle:
                            Text(_hospitalList[index]?.businessStatus ?? ""),
                        trailing: const Icon(Icons.chevron_right),
                        leading: const Icon(Icons.healing),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
