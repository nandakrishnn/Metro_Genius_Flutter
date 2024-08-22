part of 'fetch_available_works_bloc.dart';

sealed class FetchAvailableWorksState extends Equatable {
  const FetchAvailableWorksState();
  
  @override
  List<Object> get props => [];
}

final class FetchAvailableWorksInitial extends FetchAvailableWorksState {}
final class FetchAvailableWorksLoading extends FetchAvailableWorksState {}
final class FetchAvailableWorksLoaded extends FetchAvailableWorksState {
  final List<DocumentSnapshot>data;
  FetchAvailableWorksLoaded(this.data);
    @override
  List<Object> get props => [data];
}
final class FetchAvailableWorksLoadingFailure extends FetchAvailableWorksState {
  final String errorMsg;
  FetchAvailableWorksLoadingFailure(this.errorMsg);
      @override
  List<Object> get props => [errorMsg];
}