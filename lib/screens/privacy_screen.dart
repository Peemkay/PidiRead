import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Privacy Policy for PidiRead",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "Effective Date: October 26, 2023", // Update with your date
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 24),
            Text(
              "1. Information We Collect",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "We do not collect any personal information from users of PidiRead. The app operates solely on your device and does not transmit any data to our servers.",
            ),
            SizedBox(height: 24),
            Text(
              "2. How We Use Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Since we do not collect any personal information, there is no information to use. The app's functionality is limited to managing and displaying PDF files stored on your device.",
            ),
            SizedBox(height: 24),
            Text(
              "3. Changes to This Privacy Policy",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page.",
            ),
            SizedBox(height: 24),
            Text(
              "4. Contact Us",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "If you have any questions about this Privacy Policy, please contact us at your_email@example.com", // Replace with your email
            ),
            // Add more sections as needed
          ],
        ),
      ),
    );
  }
}