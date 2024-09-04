import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MetroGenius Home Service Application - Terms and Conditions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 16.0),
              _buildSectionTitle('1. Introduction'),
              _buildSectionContent(
                  'Welcome to MetroGenius, a home service application developed by Nandakrishnan. By using our services, you agree to comply with and be bound by the following Terms and Conditions. Please read these terms carefully before using our application.'),
              _buildSectionTitle('2. App Information'),
              _buildSectionContent(
                  '- App Name: MetroGenius Home Service Application\n'
                  '- Developer: Nandakrishnan\n'
                  '- Contact Information: +91 8129032567\n'
                  '- Platform: Android'),
              _buildSectionTitle('3. User Roles & Responsibilities'),
              _buildSectionContent(
                  '- User Roles: Users of MetroGenius include customers who book services through the app.\n'
                  '- User Responsibilities: Users must provide accurate personal information during registration and are expected to follow the guidelines set forth within the app. Users are prohibited from engaging in any form of harassment or abusive behavior towards service providers or other users.'),
              _buildSectionTitle('4. Services Provided'),
              _buildSectionContent(
                  '- Types of Services: MetroGenius offers various home services including plumbing, cleaning, electrical work, AC service booking, and utility repairs.\n'
                  '- Service Availability: Services are available between 8:00 AM and 6:00 PM.\n'
                  '- Service Providers: All service providers are assigned by MetroGenius after undergoing strict interviews and background checks.'),
              _buildSectionTitle('5. Payments & Refunds'),
              _buildSectionContent(
                  '- Payment Methods: MetroGenius accepts payments via Cash on Delivery and UPI.\n'
                  '- Refund Policy: No refunds will be provided for cancellations made by users.'),
              _buildSectionTitle('6. User Data'),
              _buildSectionContent(
                  '- Data Collection: We collect personal details such as phone numbers, email addresses, passwords, age, and username.\n'
                  '- Data Usage: The data collected is used strictly for the purpose of providing and improving our services.\n'
                  '- Third-Party Sharing: MetroGenius does not share user data with any third parties.'),
              _buildSectionTitle('7. Liability & Disputes'),
              _buildSectionContent(
                  '- Limitation of Liability: MetroGenius is not liable for any damages arising from the use of our services, including but not limited to service failures or data breaches.\n'
                  '- Dispute Resolution: Any disputes between users and MetroGenius will be resolved through mutual agreement, and if necessary, escalated to appropriate legal channels under Indian law.'),
              _buildSectionTitle('8. Governing Law'),
              _buildSectionContent(
                  'These Terms and Conditions are governed by and construed in accordance with the laws of India.'),
              _buildSectionTitle('9. Modification of Terms'),
              _buildSectionContent(
                  'MetroGenius reserves the right to modify these Terms and Conditions at any time. Users will be notified of any significant changes, and continued use of the app constitutes acceptance of the updated terms.'),
              _buildSectionTitle('10. Prohibited Uses'),
              _buildSectionContent(
                  '- Harassment and Abuse: Any form of harassment or abuse towards service providers or other users is strictly prohibited and may result in account suspension or termination.'),
              _buildSectionTitle('11. Help & Support'),
              _buildSectionContent(
                  'If you have any questions or need assistance, please use the help option in the app to contact our support team.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 16.0,
      ),
    );
  }
}