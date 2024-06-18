import 'package:find_hospital/bloc/hospital_cubit/find_hospital_cubit.dart';
import 'package:find_hospital/core/cache/cache.dart';
import 'package:find_hospital/core/constant/api_url.dart';
import 'package:find_hospital/core/constant/color.dart';
import 'package:find_hospital/core/constant/routes.dart';
import 'package:find_hospital/core/helper/extentions.dart';
import 'package:find_hospital/core/helper/scaffold_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../bloc/theme_cubit/theme_cubit.dart';
import '../../core/constant/animation.dart';
import '../../data/models/hospital_model.dart';
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
    context.bloc<FindHospitalCubit>().getCurrentLocation(context);
    _loadCachedHospitals();
  }

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
  List<PlaceInfo?> _hospitalList = [];
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
          endDrawer: _endDrawer(),
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
                        _buildTotalHospital(_hospitalList.isNotEmpty
                            ? _hospitalList.length
                            : _cachedHospitalList.length),
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
                                        title: Text(
                                          _hospitalList[index]?.name ?? '',
                                          style: context.textTheme.bodyMedium,
                                        ),
                                        subtitle: Text(
                                          cubit.isHospitalOpen(
                                              _hospitalList[index]?.openNow),
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                                  color: _hospitalList[index]
                                                              ?.openNow ==
                                                          true
                                                      ? Colors.green
                                                      : ColorManager.red),
                                        ),
                                        trailing:
                                            const Icon(Icons.chevron_right),
                                        leading: const Icon(Icons.healing),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : _cachedHospitalList.isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                      itemCount: _cachedHospitalList.length,
                                      itemBuilder: (context, index) {
                                        final hospital =
                                            _cachedHospitalList[index];
                                        return Card(
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                RouteManager.details,
                                                arguments: PlaceInfo(
                                                  name: hospital['name'],
                                                  rating: hospital['rate'],
                                                  placeId: hospital['placeId'],
                                                  lat: hospital['lat'],
                                                  lng: hospital['lng'],
                                                  businessStatus: hospital[
                                                      'businessStatus'],
                                                  openNow: hospital['openNow'],
                                                  userRatingsTotal: hospital[
                                                      'userRatingsTotal'],
                                                  photos: hospital['photos'] !=
                                                          null
                                                      ? List<
                                                              Map<String,
                                                                  dynamic>>.from(
                                                          hospital['photos'])
                                                      : null,
                                                  formattedPhoneNumber: hospital[
                                                      'formattedPhoneNumber'],
                                                  internationalPhoneNumber:
                                                      hospital[
                                                          'internationalPhoneNumber'],
                                                  distance:
                                                      hospital['distance'],
                                                  duration:
                                                      hospital['duration'],
                                                ),
                                              );
                                            },
                                            title: Text(hospital['name'],
                                                style: context
                                                    .textTheme.bodyMedium),
                                            subtitle: Row(
                                              children: [
                                                Text(
                                                  cubit.isHospitalOpen(
                                                    hospital['openNow'],
                                                  ),
                                                  style: context
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: hospital[
                                                                      'openNow'] ==
                                                                  true
                                                              ? Colors.green
                                                              : ColorManager
                                                                  .red),
                                                ),
                                              ],
                                            ),
                                            trailing:
                                                const Icon(Icons.chevron_right),
                                            leading: const Icon(Icons.healing),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Expanded(
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
                Positioned(
                    left: 5.w,
                    bottom: 5.h,
                    child: Card(
                      color: context.appBarTheme.backgroundColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 5.h),
                        child: Text(
                            "Last Updated: ${CacheData.getLastUpdatedTime('LastUpdated')}",
                            style: context.textTheme.bodySmall),
                      ),
                    )),
            ],
          ),
        );
      },
    );
  }

  Widget _endDrawer() {
    return Drawer(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          SizedBox(height: 30.h),
          SizedBox(
            height: context.height / 4,
            width: context.width,
            child: Card(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return Card(
                        margin: EdgeInsets.all(10.w),
                        color: state == ThemeState.green
                            ? ColorManager.green
                            : ColorManager.red,
                        child: SwitchListTile(
                          title: Text('Theme Mode',
                              style: context.textTheme.bodyLarge
                                  ?.copyWith(fontSize: 14.sp)),
                          value: state == ThemeState.green,
                          onChanged: (_) =>
                              context.bloc<ThemeCubit>().toggleTheme(),
                        ),
                      );
                    },
                  ),
                  const Spacer(flex: 2),
                  Text(
                    context.bloc<ThemeCubit>().themeTitle(),
                    style: context.textTheme.displaySmall
                        ?.copyWith(fontSize: 24.sp),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalHospital(int totalHospital) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Text(
                    "Total hospital Founded: ",
                    style: context.textTheme.bodyMedium,
                  ),
                  Text(
                    totalHospital.toString(),
                    style: context.textTheme.displayMedium,
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
    return ColorFiltered(
        colorFilter: ColorFilter.mode(
            context.appBarTheme.backgroundColor!, BlendMode.srcATop),
        child: Lottie.asset(LottieManager.loading, frameRate: FrameRate.max));
  }
}
