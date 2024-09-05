import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrogeniusapp/bloc/Admin/accept_reject/accept_reject_bloc.dart';
import 'package:metrogeniusapp/bloc/Admin/application_listing/application_listing_bloc.dart';
import 'package:metrogeniusapp/bloc/Admin/catgeories_admin/categories_bloc.dart';
import 'package:metrogeniusapp/bloc/Admin/employes_list/employes_list_bloc.dart';
import 'package:metrogeniusapp/bloc/Admin/get_category/get_category_bloc.dart';
import 'package:metrogeniusapp/bloc/add_cart_user/add_cart_user_bloc.dart';
import 'package:metrogeniusapp/bloc/adress_add_user/add_address_user_bloc.dart';
import 'package:metrogeniusapp/bloc/details_subcategory/details_sub_catgeory_bloc.dart';
import 'package:metrogeniusapp/bloc/fetch_rating_new_notable.dart/new_notable_ratings_fetch_bloc.dart';
import 'package:metrogeniusapp/bloc/forgot_pass/frogot_password_bloc.dart';
import 'package:metrogeniusapp/bloc/get_adress_user/get_user_adresses_bloc.dart';
import 'package:metrogeniusapp/bloc/get_booked_works/get_booked_works_user_bloc.dart';
import 'package:metrogeniusapp/bloc/get_cart_user/get_cart_details_user_bloc.dart';
import 'package:metrogeniusapp/bloc/get_subcategory/get_sub_catgeory_data_bloc.dart';
import 'package:metrogeniusapp/bloc/job_application/job_application_employe_bloc.dart';
import 'package:metrogeniusapp/bloc/login_bloc/user_login_bloc.dart';
import 'package:metrogeniusapp/bloc/order_summary/order_summary_bloc_bloc.dart';
import 'package:metrogeniusapp/bloc/add_ratings_user/ratings_user_bloc.dart';
import 'package:metrogeniusapp/bloc/send_message_user/message_sending_bloc_bloc.dart';
import 'package:metrogeniusapp/bloc/signup_bloc/bloc/user_signup_bloc.dart';
import 'package:metrogeniusapp/bloc/user_details/get_user_details_bloc.dart';
import 'package:metrogeniusapp/bloc/worker/edit_details_worker/edit_employe_details_bloc.dart';
import 'package:metrogeniusapp/bloc/worker/get_works/fetch_available_works_bloc.dart';
import 'package:metrogeniusapp/bloc/worker/sigin_worker/worker_sign_in_bloc.dart';
import 'package:metrogeniusapp/bloc/worker/workers_listing_user/workers_listing_user_bloc.dart';
import 'package:metrogeniusapp/firebase_options.dart';
import 'package:metrogeniusapp/services/admin/applications/admin_services.dart';
import 'package:metrogeniusapp/services/employe/employe_service.dart';
import 'package:metrogeniusapp/services/home/home_service.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';
import 'package:metrogeniusapp/services/auth.dart';
import 'package:metrogeniusapp/services/auth_signin.dart';
import 'package:metrogeniusapp/services/order_summary/order_service.dart';
import 'package:metrogeniusapp/services/workers/workers_list.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/employe_bottom_nav.dart';
import 'package:metrogeniusapp/src/splash/get_startted_1.dart';
import 'package:metrogeniusapp/src/splash/splash_screen.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/profile/user_service.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/user/screens/bottomnavigation/bottom_nav.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
//   FirebaseDatabase.instance.setPersistenceEnabled(true);
//   FirebaseDatabase.instance.setLoggingEnabled(true);

//   SharedPreferences prefs = await SharedPreferences.getInstance();
//      final String? workerId=  prefs.getString('EmployeAssigned');
//        final String? userId=  prefs.getString('UserId');
// String initialRoute;

//   if (userId != null) {
//     initialRoute = '/home';
//   } else if (workerId != null) {
//     initialRoute = '/employee_home';
//   } else {
//     initialRoute = '/splash';
//   }
  runApp(
    MyApp(
      // initialRoute: initialRoute,
    ),
  );
}




class MyApp extends StatelessWidget {
    
  const MyApp({super.key, });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserSignupBloc(AuthRepo()),
        ),
        BlocProvider(create: (context) => UserLoginBloc(UserSigninAuth())),
        BlocProvider(create: (context) => JobApplicationEmployeBloc()),
        BlocProvider(
            create: (context) => ApplicationListingBloc(AdminServices())),
        BlocProvider(
          create: (context) => AcceptRejectBloc(),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(),
        ),
        BlocProvider(
          create: (context) => GetCategoryBloc(AdminServices()),
        ),
        BlocProvider(
          create: (context) => EmployesListBloc(AdminServices()),
        ),
        BlocProvider(
          create: (context) => FrogotPasswordBloc(),
        ),
        BlocProvider(
          create: (context) => GetSubCatgeoryDataBloc(AdminServices()),
        ),
        BlocProvider(
          create: (context) => DetailsSubCatgeoryBloc(),
        ),
        BlocProvider(
          create: (context) => AddAddressUserBloc(AddressServiceUser()),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => GetUserAdressesBloc(AddressServiceUser()),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => WorkerSignInBloc(WorkersDetails()),
        ),
        BlocProvider(
          create: (context) => WorkersListingUserBloc(),
        ),
        BlocProvider(
          create: (context) => OrderSummaryBlocBloc(UserOrderService()),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => FetchAvailableWorksBloc(),
        ),
        BlocProvider(
          create: (context) => GetUserDetailsBloc(UserServices()),
        ),
        BlocProvider(create: (context) => GetBookedWorksUserBloc()),
        BlocProvider(
          create: (context) => AddCartUserBloc(AddressServiceUser()),
        ),
        BlocProvider(
          create: (context) => GetCartDetailsUserBloc(AddressServiceUser()),
        ),
        BlocProvider(
            create: (context) => RatingsUserBloc(AddressServiceUser())),
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => EditEmployeDetailsBloc(EmployeJobApplication()),

        ),
        BlocProvider(
          create: (context) => NewNotableRatingsFetchBloc(HomeService()),
       
        )
      ],
      child: MaterialApp(
          theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
          debugShowCheckedModeBanner: false,
            initialRoute: '/splash',
        routes: {
          '/splash':(context)=>const SplashScreen(),
          '/login': (context) => const GestStartedOne(),
          '/home': (context) => const BottomNavigation(),
          '/employee_home': (context) => const WorkerBottomNavigation(),
        },

          color: AppColors.primaryColor,
       ),
          
    );
  }

}



