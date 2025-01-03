import 'package:flutter/material.dart';
import 'package:planma_app/Providers/userprof_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatelessWidget {
  final String username;
  final String firstName;
  final String lastName;
  final _formKey = GlobalKey<FormState>();

  EditProfileScreen({
    super.key,
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController(text: username);
    final firstNameController = TextEditingController(text: firstName);
    final lastNameController = TextEditingController(text: lastName);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.openSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF173F70),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.yellow,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFF173F70),
                    child: IconButton(
                      icon: Icon(Icons.edit, size: 16, color: Colors.white),
                      onPressed: () {
                        // Handle edit profile picture
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Username Field
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // First Name Field
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Last Name Field
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Save Changes Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<UserProfileProvider>().updateUserProfile(
                        firstNameController.text,
                        lastNameController.text,
                        usernameController.text);
                    Navigator.pop(context, {
                      'username': usernameController.text,
                      'firstName': firstNameController.text,
                      'lastName': lastNameController.text,
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF173F70),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
