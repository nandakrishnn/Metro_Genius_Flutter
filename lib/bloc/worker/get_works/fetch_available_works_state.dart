part of 'fetch_available_works_bloc.dart';

sealed class FetchAvailableWorksState extends Equatable {
  const FetchAvailableWorksState();
  
  @override
  List<Object> get props => [];
}

final class FetchAvailableWorksInitial extends FetchAvailableWorksState {}
