import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusapp/services/workers/workers_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'fetch_available_works_event.dart';
part 'fetch_available_works_state.dart';

class FetchAvailableWorksBloc
    extends Bloc<FetchAvailableWorksEvent, FetchAvailableWorksState> {
  FetchAvailableWorksBloc() : super(FetchAvailableWorksInitial()) {
    on<FetchJobsData>(_fetchJobsData);
    on<FetchAcceptedJobsData>(_fetchAcceptedJobsData);
    on<FetchCompleatedJobsData>(_fetchCompleatedJobsData);
    on<FetchWorksByDate>(_fetchWorksByDate);
    on<FetchedJobsData>(_fetchedData);
  }
  void _fetchJobsData(
      FetchJobsData event, Emitter<FetchAvailableWorksState> emit) async {
    emit(FetchAvailableWorksLoading());
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>>? categoryStream =
          await WorkersDetails.getRequests();

      categoryStream.listen((snapshots) async {
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
            snapshots.docs;

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String? employeeId = prefs.getString('EmployeAssigned');

        final List<QueryDocumentSnapshot<Map<String, dynamic>>>
            filteredRequests = [];
        for (var doc in data) {
          String requestTimeStr = doc['DateTime'];

          print(requestTimeStr);
          print(employeeId);
          bool isAllocated =
              await workAllocatedOrNot(employeeId!, requestTimeStr);

          if (!isAllocated) {
            filteredRequests.add(doc);
          }
        }

        // Add the event with filtered data
        add(FetchedJobsData(filteredRequests));
      });
    } catch (e) {
      emit(FetchAvailableWorksLoadingFailure(e.toString()));
    }
  }

  void _fetchAcceptedJobsData(FetchAcceptedJobsData event,
      Emitter<FetchAvailableWorksState> emit) async {
    emit(FetchAvailableWorksLoading());
    try {
      Stream<QuerySnapshot<Object?>>? catgeoryStream =
          await WorkersDetails.getAcceptedRequests();
      catgeoryStream.listen((snapshots) {
        final data = snapshots.docs;
        add(FetchedJobsData(
            data.cast<DocumentSnapshot<Map<String, dynamic>>>()));
      });
    } catch (e) {
      emit(FetchAvailableWorksLoadingFailure(e.toString()));
    }
  }

  void _fetchCompleatedJobsData(FetchCompleatedJobsData event,
      Emitter<FetchAvailableWorksState> emit) async {
    emit(FetchAvailableWorksLoading());
    try {
      Stream<QuerySnapshot<Object?>>? catgeoryStream =
          await WorkersDetails.getCompleatedRequests();
      catgeoryStream.listen((snapshots) async {
        final data = snapshots.docs;

        add(FetchedJobsData(
            data.cast<DocumentSnapshot<Map<String, dynamic>>>()));
      });
    } catch (e) {
      emit(FetchAvailableWorksLoadingFailure(e.toString()));
    }
  }
   void _fetchWorksByDate(
      FetchWorksByDate event, Emitter<FetchAvailableWorksState> emit) async {
    emit(FetchAvailableWorksLoading());
    try {
   
     
      Stream<QuerySnapshot<Map<String, dynamic>>>? categoryStream =
          await WorkersDetails.getRequestsByDate(event.selectedDate);

      categoryStream.listen((snapshots) async {
           print('Received snapshots: ${snapshots.docs.length} documents');
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
            snapshots.docs;

        add(FetchedJobsData(
            data.cast<DocumentSnapshot<Map<String, dynamic>>>()));
      });
    } catch (e) {
      emit(FetchAvailableWorksLoadingFailure(e.toString()));
    }
  }

  void _fetchedData(
      FetchedJobsData event, Emitter<FetchAvailableWorksState> emit) {
    emit(FetchAvailableWorksLoaded(event.data));
  }

  Future<bool> workAllocatedOrNot(String employeId, String timeDate) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collectionGroup("UserOrders")
          .where('WorkerId', isEqualTo: employeId)
          .where('DateTime', isEqualTo: timeDate)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking work allocation: $e');
      return false;
    }
  }

 
}
