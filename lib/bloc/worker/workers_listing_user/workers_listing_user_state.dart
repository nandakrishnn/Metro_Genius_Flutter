part of 'workers_listing_user_bloc.dart';

sealed class WorkersListingUserState extends Equatable {
  const WorkersListingUserState();
  
  @override
  List<Object> get props => [];
}

final class WorkersListingUserInitial extends WorkersListingUserState {}
final class WorkersListingUserLoading extends WorkersListingUserState {}
final class WorkersListingUserLoaded extends WorkersListingUserState {
DocumentSnapshot data;
  WorkersListingUserLoaded(this.data);
    
  @override
  List<Object> get props => [data];
}
final class WorkersListingUserFailure extends WorkersListingUserState {
  final String errroMsg;
  WorkersListingUserFailure(this.errroMsg);
    @override
  List<Object> get props => [errroMsg];
}
