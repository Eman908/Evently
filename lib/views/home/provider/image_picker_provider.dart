// import 'dart:io';

// import 'package:evently/firebase/firebase_service.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImagePickerProvider extends ChangeNotifier {
//   File? imageFile;
//   final bool isUploading = false;

//   Future<void> pickAndUploadImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.camera);

//     if (image == null) return;

//     final file = File(image.path);
//     final url = await FirebaseService().uploadProfileImage(file);

//     if (url != null) {
//       debugPrint('✅ Uploaded! URL: $url');
//     }
//     notifyListeners();
//   }
// }
