import 'package:flutter/material.dart';

class WorkerInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MetroGenius - Worker Info'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MetroGenius - Worker Info Page',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'App Name: MetroGenius',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Role of the Worker:\n'
              'As a worker in MetroGenius, your role is to serve as a professional representative of the company. Your responsibilities include:\n'
              '- Providing excellent service with professionalism and respect towards every customer.\n'
              '- Collecting payments from customers and ensuring the funds are transferred accurately to the company\'s account.',
              style: TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Key Functionalities for Workers:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '1. Job Management:\n'
              '- View assigned tasks and manage your daily schedule directly in the app.\n'
              '- Update the status of jobs (e.g., started, in-progress, completed) to keep the team informed.\n'
              '\n'
              '2. Communication:\n'
              '- Use the in-app messaging system to communicate with customers and the MetroGenius support team.\n'
              '- Maintain clear and respectful communication with every client.\n'
              '\n'
              '3. Payment Collection:\n'
              '- Collect payments from customers as per the service provided.\n'
              '- Follow the guidelines for securely transferring the collected funds to the company\'s account.',
              style: TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Instructions for Workers:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Logging In:\n'
              '  - Use your registered credentials to log into the app. If you face any login issues, contact support for assistance.\n'
              '\n'
              '- Handling Tasks:\n'
              '  - Review your tasks daily to stay updated on your schedule.\n'
              '  - Confirm each job’s details before starting and communicate any discrepancies immediately.\n'
              '\n'
              '- Payment Processing:\n'
              '  - Collect payments promptly after completing a service.\n'
              '  - Ensure all funds are correctly transferred to the company\'s account using the app\'s payment transfer feature.',
              style: TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Support and Assistance:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Contact Information:\n'
              '  - For any issues or questions, reach out to MetroGenius support through the in-app chat or call our helpline at [Support Number].\n'
              '  - You can also email us at [Support Email] for any non-urgent queries.\n'
              '\n'
              '- Frequently Asked Questions (FAQs):\n'
              '  - Check the FAQs section in the app for answers to common questions about task management, payment processing, and more.',
              style: TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Compliance and Safety Information:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Always ensure that your actions comply with MetroGenius\'s standards and policies.\n'
              '- Maintain a professional demeanor, respect customer privacy, and handle all payments securely.',
              style: TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Tips for Effective Use:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Stay Updated: Regularly check your app for updates on tasks and payments.\n'
              '- Be Professional: Remember that you represent MetroGenius—maintain professionalism and respect in all interactions.\n'
              '- Follow Up: If you encounter any issues during your tasks, report them promptly to ensure a smooth resolution.',
              style: TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Update and Version Information:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Keep your app updated to access the latest features and improvements. Notifications for updates will appear within the app.',
              style: TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Permissions:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Ensure you grant necessary permissions like location services and notifications to make the most out of the app features.',
              style: TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Visuals and Branding:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Familiarize yourself with the MetroGenius logo and branding. Ensure your presentation aligns with the company’s professional image.',
              style: TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
