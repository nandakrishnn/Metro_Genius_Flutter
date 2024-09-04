part of 'edit_employe_details_bloc.dart';

sealed class EditEmployeDetailsEvent{}
final class EmployeeNameChanges extends EditEmployeDetailsEvent{
String name;
EmployeeNameChanges(this.name);
}
final class EmployeeImageChanges extends EditEmployeDetailsEvent{
String image;
EmployeeImageChanges(this.image);
}
final class EmployeeExpChanges extends EditEmployeDetailsEvent{
int expEmploye;
EmployeeExpChanges(this.expEmploye);
}
final class EmployeePhone extends EditEmployeDetailsEvent{
int expPhone;
EmployeePhone(this.expPhone);
}
final class UpdatedFormSubmit extends EditEmployeDetailsEvent{}