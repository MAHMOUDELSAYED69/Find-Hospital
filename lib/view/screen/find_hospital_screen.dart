import 'package:find_hospital/bloc/hospital_cubit/find_hospital_cubit.dart';
import 'package:find_hospital/utils/cache/cache.dart';

import 'package:find_hospital/utils/helper/extentions.dart';
import 'package:find_hospital/utils/helper/scaffold_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../utils/constant/animation.dart';
import '../../data/models/hospital_model.dart';
import '../widget/cached_hospitals_listview.dart';
import '../widget/custom_dropdown.dart';
import '../widget/hospital_card.dart';
import '../widget/hospitals_listview.dart';
import '../widget/last_updated_card.dart';
import '../widget/my_drawer.dart';

class FindHospitalScreen extends StatefulWidget {
  const FindHospitalScreen({super.key});

  @override
  State<FindHospitalScreen> createState() => _FindHospitalScreenState();
}

class _FindHospitalScreenState extends State<FindHospitalScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<FindHospitalCubit>().getCurrentLocation(context);
    _loadCachedHospitals();
  }

  //?-------------------------------------------------------- load cached hospitals Method
  Future<void> _loadCachedHospitals() async {
    List<Map<String, dynamic>> cachedData =
        CacheData.getListOfMaps(key: 'nearestHospitals');
    if (cachedData.isNotEmpty) {
      setState(() {
        _cachedHospitalList = cachedData;
      });
    }
  }

  bool _isLoading = false;
  List<HospitalsPlaceInfo?> _hospitalList = [];
  List<Map<String, dynamic>> _cachedHospitalList = [];
  @override
  Widget build(BuildContext context) {
    final cubit = context.bloc<FindHospitalCubit>();
    return BlocConsumer<FindHospitalCubit, FindHospitalState>(
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
        return Scaffold(
          appBar: AppBar(
            title: const Text("Find Hospital"),
          ),
          endDrawer: const MyDrawer(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: context.appBarTheme.backgroundColor,
            onPressed: !_isLoading
                ? () {
                    cubit.getCurrentLocation(context);
                    cubit.getNearestHospitals(radius: selectedDoubleValue);
                  }
                : null,
            child: Icon(Icons.location_on, color: context.iconTheme.color),
          ),
          body: Stack(
            children: [
              _isLoading
                  ? Center(child: _buildLoadingIndicator())
                  : Column(
                      children: [
                        //?---------------------------------------------- Total Hospitals
                        HospitalRatingCard(
                            totalHospital: _hospitalList.isNotEmpty
                                ? _hospitalList.length
                                : _cachedHospitalList.length),
                        _hospitalList.isNotEmpty
                            //?--------------------------------------------------- Hospital list
                            ? HopitalsListViewBuilder(
                                hospitalList: _hospitalList, cubit: cubit)
                            : _cachedHospitalList.isNotEmpty
                                //?--------------------------------------------- Cahced Hospital list
                                ? CachedHospitalsListViewBuilder(
                                    cachedHospitalList: _cachedHospitalList)
                                : Expanded(
                                    //? ----------------------------------------- Search Icon
                                    child: Icon(
                                      Icons.find_replace_rounded,
                                      size: 100.sp,
                                      color:
                                          context.appBarTheme.backgroundColor,
                                    ),
                                  ),
                      ],
                    ),
              if (_hospitalList.isEmpty &&
                  _cachedHospitalList.isNotEmpty &&
                  CacheData.getLastUpdatedTime('LastUpdated') != null &&
                  state is! FindHospitalLoading)
                const LastUpdatedCard(), //?----------------------------------- Last Updaeted Card
            ],
          ),
        );
      },
    );
  }

  //?----------------------------------------------------------------------- Loading indicator
  Widget _buildLoadingIndicator() {
    return ColorFiltered(
        colorFilter: ColorFilter.mode(
            context.appBarTheme.backgroundColor!, BlendMode.srcATop),
        child: Lottie.asset(LottieManager.loading, frameRate: FrameRate.max));
  }
}
