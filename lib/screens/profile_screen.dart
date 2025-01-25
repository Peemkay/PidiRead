
import 'dart:io'; // Import for File
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import for Firebase Storage

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  void _checkCurrentUser() {
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
        _usernameController.text = user?.displayName ?? ''; // Set initial username
      });
    });
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      // Navigate to login screen after sign out
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _uploadImageAndUpdateProfile() async {
    if (_imageFile != null) {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child('profile_photos/${_user!.uid}.jpg');
      await storageRef.putFile(File(_imageFile!.path));
      final downloadURL = await storageRef.getDownloadURL();

      // Update profile photo URL in Firebase Authentication
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadURL);
      // Show success message or update UI
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile photo uploaded successfully!')),
      );
    }
  }

  Future<void> _updateUsername() async {
    try {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(_usernameController.text);
      // Show success message or update UI
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username updated successfully!')),
      );
    } on FirebaseAuthException catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating username: $e')),
      );
    }
  }

  Future<void> _changePassword() async {
    try {
      // Verify current password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _user!.email!,
        password: _currentPasswordController.text,
      );

      // Update password
      await FirebaseAuth.instance.currentUser?.updatePassword(_newPasswordController.text);
      // Show success message or update UI
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully!')),
      );
    } on FirebaseAuthException catch (e) {
      // Handle errors, e.g., wrong password
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error changing password: $e')),
      );
    }
  }

  Future<void> _deleteAccount() async {
    try {
      await _user!.delete(); // Delete the user from Firebase
      Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        // Prompt the user to re-authenticate before deleting
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please re-login to delete your account.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting account: $e')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: _user == null
          ? const Center(child: CircularProgressIndicator()) // Loading indicator
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                backgroundImage: _user!.photoURL != null ? NetworkImage(_user!.photoURL!) : null,
                child: _user!.photoURL == null ? const Icon(Icons.person, size: 80, color: Colors.white) : null,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column( // Wrap Image.file and ElevatedButton in a Column
                children: [
                  IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo_camera),
                  ),
                  if (_imageFile != null) Image.file(File(_imageFile!.path)),
                  ElevatedButton(
                    onPressed: _uploadImageAndUpdateProfile,
                    child: const Text('Upload Profile Photo'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                _user!.displayName ?? "User Name", // Display user name
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                _user!.email ?? "user@example.com", // Display user email
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            Padding( // Wrap TextField and ElevatedButton with Padding
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
              child: Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  ElevatedButton(
                    onPressed: _updateUsername,
                    child: const Text('Update Username'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding( // Wrap Password fields and ElevatedButton with Padding
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _currentPasswordController,
                    decoration: const InputDecoration(labelText: 'Current Password'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: _newPasswordController,
                    decoration: const InputDecoration(labelText: 'New Password'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: _changePassword,
                    child: const Text('Change Password'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _signOut,
                child: const Text("Logout"),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _deleteAccount,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Delete Account", style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}