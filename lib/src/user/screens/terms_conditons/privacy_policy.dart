import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Effective Date: 04-Sept-2024',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24.0),
            _buildSectionTitle('1. Introduction'),
            _buildSectionContent(
              'Welcome to MetroGenius. We are committed to protecting your personal information and your right to privacy. This Privacy Policy explains how we collect, use, and protect your information when you use our home service application.',
            ),
            _buildSectionTitle('2. Information We Collect'),
            _buildSectionContent(
              'We collect the following types of personal information:\n\n'
              '  - Personal Information:\n'
              '  - Email address\n'
              '  - Username\n'
              '  - Phone number',
            ),
            _buildSectionTitle('3. How We Collect Your Information'),
            _buildSectionContent(
              'We collect your personal information directly from you when you:\n\n'
              '- Register or create an account\n'
              '- Use our application for home services',
            ),
            _buildSectionTitle('4. How We Use Your Information'),
            _buildSectionContent(
              'We use the collected information for the following purposes:\n\n'
              '- To provide and manage our home service application\n'
              '- To communicate with you, including sending notifications and updates related to our services\n'
              '- To authenticate your account and ensure security',
            ),
            _buildSectionTitle('5. Information Sharing'),
            _buildSectionContent(
              'We do not share your personal information with third parties. Your data is solely used to provide and improve our services and ensure the security of your account.',
            ),
            _buildSectionTitle('6. Data Security'),
            _buildSectionContent(
              'We implement various security measures to protect your personal information, including:\n\n'
              '- Encryption: Data is encrypted during transmission and storage.\n'
              '- Secure Servers: We use secure servers to store your information and protect it from unauthorized access.',
            ),
            _buildSectionTitle('7. Data Retention'),
            _buildSectionContent(
              'We retain your personal information only as long as necessary to fulfill the purposes for which it was collected, including to provide our services and comply with legal obligations.',
            ),
            _buildSectionTitle('8. Your Rights'),
            _buildSectionContent(
              'You have the following rights regarding your personal information:\n\n'
              '- Access: You can access your personal information by logging into your account.\n'
              '- Correction: You can update or correct your information through your account settings.\n'
              '- Deletion: You can request the deletion of your account and personal information by contacting us.',
            ),
            _buildSectionTitle('9. Changes to This Privacy Policy'),
            _buildSectionContent(
              'We may update this Privacy Policy from time to time. Any changes will be posted on this page, and the effective date will be updated accordingly. We encourage you to review this Privacy Policy periodically.',
            ),
            _buildSectionTitle('10. Compliance with Regulations'),
            _buildSectionContent(
              'We comply with relevant data protection regulations applicable to our operations. If you have any concerns about how we handle your personal information, please contact us.',
            ),
            _buildSectionTitle('11. Contact Us'),
            _buildSectionContent(
              'If you have any questions or concerns about this Privacy Policy, please contact us at:\n\n'
              '- Email:\n   followmenandakrishnan@gmail.com\n'
              '- Phone:\n  +918129032567',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black87,
        ),
      ),
    );
  }
}
