import 'package:bloc/bloc.dart';
import 'package:metrogeniusapp/services/employe/employe_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_employe_details_event.dart';
part 'edit_employe_details_state.dart';

class EditEmployeDetailsBloc
    extends Bloc<EditEmployeDetailsEvent, EditEmployeDetailsState> {
  final EmployeJobApplication employeService;
  EditEmployeDetailsBloc(this.employeService)
      : super(EditEmployeDetailsState()) {
    on<EmployeeNameChanges>(_employeeName);
    on<EmployeeImageChanges>(_employeeImage);
    on<EmployeeExpChanges>(_employeeExp);
    on<EmployeePhone>(_employeePhone);
    on<UpdatedFormSubmit>(__onUpdateFormSubmit);
  }
  _employeeName(
      EmployeeNameChanges event, Emitter<EditEmployeDetailsState> emit) {
    emit(state.copyWith(workerName: event.name));
  }

  _employeeImage(
      EmployeeImageChanges event, Emitter<EditEmployeDetailsState> emit) {
    emit(state.copyWith(workerImage: event.image));
  }

  _employeeExp(
      EmployeeExpChanges event, Emitter<EditEmployeDetailsState> emit) {
    emit(state.copyWith(workerExp: event.expEmploye));
  }

  _employeePhone(EmployeePhone event, Emitter<EditEmployeDetailsState> emit) {
    emit(state.copyWith(workerPhone: event.expPhone));
  }

  void __onUpdateFormSubmit(
      UpdatedFormSubmit event, Emitter<EditEmployeDetailsState> emit) async {
    try {
      final updatedDetails={
        'ApplicantExperience':state.workerExp,
        'ApplicantName':state.workerName,
        'ApplicantPhone':state.workerPhone,
        'ApplicantImage':state.workerImage
      };
      emit(state.copyWith(status: EditStatus.pending));
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final employeCode = prefs.getString('WorkerId');
      print(employeCode);
      print('anwar');
      final added = await employeService.updateEmployeeDetails(
          employeCode!,
          updatedDetails
      );
      print(added);
      if (added == true) {
        print(added);
        emit(state.copyWith(status: EditStatus.sucess));
      } else {
        emit(state.copyWith(status: EditStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: EditStatus.failure));
    }
  }
}
