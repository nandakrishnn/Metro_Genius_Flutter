import 'package:flutter/material.dart';
import 'package:metrogeniusapp/src/employe/widgets/custom_textfeild.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class DetailsWorker extends StatelessWidget {
  final data;
  const DetailsWorker({super.key, this.data});

  @override
  Widget build(BuildContext context) {
     TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController workController = TextEditingController();
    TextEditingController yearsController = TextEditingController();
    nameController.text=data['ApplicantName'];
    phoneController.text=data['ApplicantPhone'].toString();
    emailController.text=data['ApplicantEmail'];
    workController.text=data['ApplicantWorkType'];
    yearsController.text=data['ApplicantExperience'].toString();

    return  Scaffold(
      appBar: AppBar(
        title: Text('Personal Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                                AppConstants.kheight30,
                CircleAvatar(
                    radius: 90,
                    backgroundImage: NetworkImage(data['ApplicantImage']),
                ),
                      AppConstants.kheight20,
                      CustomTextFeild2(
                      
                          controller: nameController,
                          heading: 'Full Name',
                          hinttext: 'Full Name',
                       ),
                      AppConstants.kheight20,
                      CustomTextFeild2(
                      
                        controller: phoneController,
                        heading: 'Phone Number',
                        hinttext: 'Phone Number',
                        keybordtype: TextInputType.phone,
                        
                            
                      ),
                      AppConstants.kheight20,
                      CustomTextFeild2(
                        
                          controller: emailController,
                          heading: 'Email Address',
                          hinttext: 'Email Address',
                          keybordtype: TextInputType.emailAddress,
                      ),
                      AppConstants.kheight20,
                      CustomTextFeild2(
                        readOnly: true,
                        //  onChanged: (value) => context.read<JobApplicationEmployeBloc>().add(UserWorkType(workController.text)),
                        
                        tap: () {
                    
                        },
                        controller: workController,
                        heading: ' Work type',
                        hinttext: 'e.g. Plumber, Electrician etc',
            
                   
                      ),
                      AppConstants.kheight20,
                      CustomTextFeild2(
                       
                          controller: yearsController,
                          heading: 'Years of experience',
                          hinttext: 'Years of experience',
                          keybordtype: TextInputType.number,
                      
                            ),
                      AppConstants.kheight20,
                    
                     
                      GestureDetector(
                          onTap: () async {
                           
                          },
                          child: LoginContainer(content: 'Save')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}