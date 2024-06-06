import 'package:bloc/bloc.dart';
import 'package:find_hospital/core/helper/location.dart';
import 'package:find_hospital/data/models/hospital_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../../data/services/find_hospital.dart';

part 'find_hospital_state.dart';

class FindHospitalCubit extends Cubit<FindHospitalState> {
  FindHospitalCubit() : super(FindHospitalInitial());
  Position? location;
  List<PlaceInfo> hospitalsList = [];
  Future<void> getCurrentLocation(context) async {
    location = await LocationHelper.determineCurrentPosition(context);
    if (location == null) {
      getCurrentLocation(context);
    }
  }

  Future<void> getNearestHospitals({double? radius}) async {
    try {
      if (location != null) {
        emit(FindHospitalLoading());
        hospitalsList = await FindHospitalWebService.getNearestHospital(
            location!.latitude, location!.longitude, radius ?? 5000);
        emit(FindHospitalSuccess());
      }
    } catch (err) {
      emit(FindHospitalFailure(message: err.toString()));
    }
  }
}
