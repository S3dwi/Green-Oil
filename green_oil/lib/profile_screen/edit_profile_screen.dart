import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:green_oil/nav_bar.dart';
import 'package:green_oil/sign_in_screen/signin_signup.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:green_oil/profile_screen/edit_account_card.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EditProfileScreenState();
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _pickedImageFile;
  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  bool _isLoading = false;

  void _updateProfile() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      Map<String, dynamic> updateData = {}; // Map to hold the updates

      // Indicate loading
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }

      try {
        // Check if the image file was picked and upload it
        if (_pickedImageFile != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('user_images')
              .child('${firebaseUser.uid}.jpg');

          await storageRef.putFile(_pickedImageFile!);
          final imageUrl = await storageRef.getDownloadURL();
          updateData['image_url'] = imageUrl; // Add image URL to update data
        }

        // Add name and phone number to updateData if they are not empty
        if (_name.text.isNotEmpty) {
          updateData['Name'] = _name.text;
        }
        if (_phoneNumber.text.isNotEmpty) {
          updateData['Phone'] = _phoneNumber.text;
        }

        // If there's anything to update, proceed
        if (updateData.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('provider')
              .doc(firebaseUser.uid)
              .update(updateData);
          if (mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NavBar(wantedPage: 2),
              ),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('No changes to update'),
              ),
            );
          }
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error updating profile: $error'),
            ),
          );
        }
      } finally {
        // Always runs even if there is an error
        if (mounted) {
          setState(() {
            _isLoading = false; // Stop loading
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents resizing on keyboard open
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 420,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 340,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.surfaceContainer,
                        Theme.of(context).colorScheme.surfaceContainerHigh,
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Positioned(
                        left: 0,
                        top: 50,
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back_ios_new),
                          iconSize: 30,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Positioned(
                        top: 55,
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 120,
                        child: CircleAvatar(
                          radius: 64,
                          backgroundImage: _pickedImageFile != null
                              ? FileImage(_pickedImageFile!)
                              : const AssetImage(
                                  'assets/images/profile_picture.png',
                                ) as ImageProvider,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              radius: 20,
                              child: IconButton(
                                onPressed: _pickImage,
                                icon: Icon(
                                  Icons.edit,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 18,
                  left: 18,
                  child: EditAccountCard(
                    label: "Name",
                    value: "Enter Name",
                    maxLength: 50,
                    keyboardType: TextInputType.name,
                    controller: _name,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          EditAccountCard(
            label: "Phone Number",
            value: "Enter Phone Number",
            maxLength: 10,
            keyboardType: TextInputType.phone,
            controller: _phoneNumber,
          ),
          const SizedBox(height: 50),
          const Spacer(),
          SigninSignup(
            onPressed: _isLoading ? () {} : _updateProfile,
            vertical: _isLoading ? 15 : 13,
            horizontal: _isLoading ? 165 : 145,
            child: _isLoading
                ? SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                : Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Take Picture'),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
          content: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedImage = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedImage != null) {
                      setState(() {
                        _pickedImageFile = File(pickedImage.path);
                      });
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.image,
                        size: 70,
                      ),
                      const Text("Gallery")
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedImage = await picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (pickedImage != null) {
                      setState(() {
                        _pickedImageFile = File(pickedImage.path);
                      });
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.camera_alt,
                        size: 70,
                      ),
                      const Text("Camera")
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
