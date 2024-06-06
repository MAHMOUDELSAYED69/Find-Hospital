import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'find_hospital_state.dart';

class FindHospitalCubit extends Cubit<FindHospitalState> {
  FindHospitalCubit() : super(FindHospitalInitial());

  
}
