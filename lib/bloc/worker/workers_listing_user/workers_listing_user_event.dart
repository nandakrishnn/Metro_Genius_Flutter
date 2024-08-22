part of 'workers_listing_user_bloc.dart';

sealed class WorkersListingUserEvent extends Equatable {
  const WorkersListingUserEvent();

  @override
  List<Object> get props => [];
}
final class WorkersFetchData extends WorkersListingUserEvent{

}
final class WorkersFetchedData extends WorkersListingUserEvent{
  final DocumentSnapshot workerSnapshot;

  WorkersFetchedData(this.workerSnapshot);

  @override
  List<Object> get props => [workerSnapshot];

  // Helper method to extract data
  Map<String, dynamic> get data => workerSnapshot.data() as Map<String, dynamic>;
}
final class WorkersDataCleared extends WorkersListingUserEvent{

}



