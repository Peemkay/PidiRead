import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Us")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Get in Touch",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "We'd love to hear from you! If you have any questions, feedback, or suggestions, please don't hesitate to contact us using the information below:",
            ),
            const SizedBox(height: 24),
            const Text(
              "Email:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () async {
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'your_email@example.com', // Replace with your email
                  queryParameters: {'subject': 'PidiRead App Inquiry'},
                );
                if (await canLaunchUrlString(emailUri.toString())) {
                  await launchUrlString(emailUri.toString());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not launch email app.')),
                  );
                }
              },
              child: const Text(
                'your_email@example.com', // Replace with your email
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Website:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () async {
                const url = 'https://www.yourwebsite.com'; // Replace with your website
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not launch website.')),
                  );
                }
              },
              child: const Text(
                'www.yourwebsite.com', // Replace with your website
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Phone:", // Optional
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              "+1-555-123-4567", // Replace with your phone number
            ),
            const SizedBox(height: 16),
            const Text(
              "Address:", // Optional
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              "123 Main Street, City, State, ZIP", // Replace with your address
            ),
          ],
        ),
      ),
    );
  }
}