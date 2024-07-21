import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/src/admin/applicant_details/applicant_deatils.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Admin Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
        
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(createRoute(ApplicantDeatils()));
              },
              child: Container(
                decoration: BoxDecoration(
                  
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0,0),
                      spreadRadius: 2,
                      blurRadius: 2
                    )
                  ],
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.adminMaincolor.withOpacity(0.01)
                  
                ),
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width * 0.5,
                child:const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          AppConstants.kheight10,
                      Text(
                        'Applicants',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
