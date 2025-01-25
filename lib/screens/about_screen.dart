import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About PidiRead")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center( // Center the app icon
              child: Image.asset(
                'assets/app_icon.png', // Replace with your app icon path
                height: 100,
              ),
            ),
            const SizedBox(height: 24),
            const Center( // Center the app name
              child: Text(
                "PidiRead",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Version: 1.0.0", // Replace with your app version
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 24),
            const Text(
              "PidiRead is designed to simplify how you manage and read your PDF documents. By organizing PDFs into chapters, we aim to provide a more structured and enjoyable reading experience.",
            ),
            const SizedBox(height: 16),
            const Text(
              "Key Features:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text("- Organize PDFs into chapters"),
            const Text("- Easy access to your reading material"),
            // Add more key features
            const SizedBox(height: 24),
            const Text(
              "Developed by:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              "Peemkay/PeemkayTECH", // Replace with your name or company
            ),
            const SizedBox(height: 16),
            const Text(
              "Contact:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              "ariespeemkay@gmail.com", // Replace with your contact email
            ),
          ],
        ),
      ),
    );
  }
}