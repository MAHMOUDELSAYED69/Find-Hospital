part of 'find_hospital_cubit.dart';

@immutable
abstract class FindHospitalState {}

class FindHospitalInitial extends FindHospitalState {}

class FindHospitalLoading extends FindHospitalState {}

class FindHospitalSuccess extends FindHospitalState {
  final List<HospitalsPlaceInfo?> hospitalsList;

  FindHospitalSuccess({required this.hospitalsList});
}

class FindHospitalFailure extends FindHospitalState {
  final String message;
  FindHospitalFailure({required this.message});
}

class OpenMapsLoading extends FindHospitalState {}

class OpenMapsSuccess extends FindHospitalState {}

class OpenMapsFailure extends FindHospitalState {
  final String message;
  OpenMapsFailure({required this.message});
}
