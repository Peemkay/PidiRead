import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pidiread/models/chapter.dart';
import 'package:pidiread/widgets/chapter_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about_screen.dart';
import 'contact_screen.dart';
import 'faq_screen.dart';
import 'privacy_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Chapter> chapters = [];

  @override
  void initState() {
    super.initState();
    _loadChapters();
  }

  Future<void> _loadChapters() async {
    final prefs = await SharedPreferences.getInstance();
    final chapterJson = prefs.getStringList('chapters') ?? [];
    setState(() {
      chapters = chapterJson
          .map((json) => Chapter.fromJson(jsonDecode(json)))
          .toList();
    });
  }

  Future<void> _saveChapters() async {
    final prefs = await SharedPreferences.getInstance();
    final chapterJson = chapters.map((chapter) => jsonEncode(chapter.toJson())).toList();
    await prefs.setStringList('chapters', chapterJson);
  }

  Future<void> _addChapter() async {
    try{
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          chapters.add(Chapter(
            title: result.files.first.name,
            filePath: result.files.first.path!,
          ));
          _saveChapters();
        });
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding PDF: $e')), // Better error handling
      );
    }
  }

  void _removeChapter(int index) {
    setState(() {
      chapters.removeAt(index);
      _saveChapters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PidiRead'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'PidiRead Menu',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Privacy & Policy'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrivacyScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('FAQ'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FAQScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _addChapter,
              child: const Text('Add Chapter'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chapters.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ChapterButton(chapter: chapters[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => _removeChapter(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}