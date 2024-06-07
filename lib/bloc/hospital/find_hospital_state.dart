part of 'find_hospital_cubit.dart';

@immutable
abstract class FindHospitalState {}

class FindHospitalInitial extends FindHospitalState {}

class FindHospitalLoading extends FindHospitalState {}

class FindHospitalSuccess extends FindHospitalState {
  final List<PlaceInfo?> hospitalsList;

  FindHospitalSuccess({required this.hospitalsList});
}

class FindHospitalFailure extends FindHospitalState {
  final String message;
  FindHospitalFailure({required this.message});
}
