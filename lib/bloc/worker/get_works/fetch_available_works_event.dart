part of 'fetch_available_works_bloc.dart';

sealed class FetchAvailableWorksEvent {
   const FetchAvailableWorksEvent();

  List<Object> get props => [];
}
final class FetchJobsData extends FetchAvailableWorksEvent{}
final class FetchAcceptedJobsData extends FetchAvailableWorksEvent{}
final class FetchCompleatedJobsData extends FetchAvailableWorksEvent{}

final class FetchedJobsData extends FetchAvailableWorksEvent{
  
 final List<DocumentSnapshot<Map<String, dynamic>>> data;
  FetchedJobsData(this
  .data);
    List<Object> get props => [data];
}
class FetchWorksByDate extends FetchAvailableWorksEvent {
  final String selectedDate;

  FetchWorksByDate(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}