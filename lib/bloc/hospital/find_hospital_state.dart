part of 'find_hospital_cubit.dart';

@immutable
abstract class FindHospitalState {}

class FindHospitalInitial extends FindHospitalState {}

class FindHospitalLoading extends FindHospitalState {}

class FindHospitalSuccess extends FindHospitalState {}

class FindHospitalFailure extends FindHospitalState {
  final String message;
  FindHospitalFailure({required this.message});
}
