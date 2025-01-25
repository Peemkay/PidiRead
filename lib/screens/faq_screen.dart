import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Frequently Asked Questions"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
          children: const [
            Text(
              "General",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ExpansionTile(
              title: Text("What is PidiRead?"),
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "PidiRead is a mobile application designed to help you organize and read your PDF documents in a chapter-like structure. It simplifies managing and accessing your digital reading materials.",
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text("Is PidiRead free?"),
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Yes, PidiRead is currently free to use. We may introduce optional premium features in the future, but the core functionality will remain free.",
                  ),
                ),
              ],
            ),
            SizedBox(height: 24), // Add spacing between sections
            Text(
              "Using PidiRead",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ExpansionTile(
              title: Text("How do I add a PDF?"),
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "To add a PDF, tap the 'Add Chapter' button on the home screen. This will open your device's file picker, allowing you to select a PDF file from your local storage.",
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text("How do I remove a chapter?"),
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "You can remove a chapter by tapping the remove icon (usually an 'X' or a trash can icon) next to the chapter title on the home screen.",
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text("Can I search within a PDF?"),
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "The current version of PidiRead does not support in-PDF searching. This is a feature we are considering for future updates.",
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              "Troubleshooting",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ExpansionTile(
              title: Text("I'm having trouble opening a PDF."),
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "If you encounter issues opening a PDF, please ensure that the file is not corrupted and that it is a valid PDF file. If the problem persists, please contact our support team.",
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text("The app is crashing."),
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "If the app is crashing, try restarting your device. If the issue continues, please contact our support team with details about when the crash occurs.",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}