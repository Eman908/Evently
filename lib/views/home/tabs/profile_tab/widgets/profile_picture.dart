// import 'dart:io';
// import 'package:evently/firebase/firebase_service.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:evently/core/app_colors.dart';

// class ProfilePicture extends StatefulWidget {
//   const ProfilePicture({super.key});

//   @override
//   State<ProfilePicture> createState() => _ProfilePictureState();
// }

// class _ProfilePictureState extends State<ProfilePicture> {
//   File? _imageFile;
//   bool _isUploading = false;

//   Future<void> _pickAndUploadImage() async {
//     final picker = ImagePicker();
//     try {
//       final picked = await picker.pickImage(source: ImageSource.camera);
//       if (picked == null) return;

//       setState(() {
//         _imageFile = File(picked.path);
//         _isUploading = true;
//       });

//       final url = await FirebaseService().uploadProfileImage(_imageFile!);

//       if (url != null) {
//         debugPrint('✅ Uploaded! URL: $url');
//         // Optional: update Firebase Auth profile
//         // await FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
//       } else {
//         debugPrint('⚠️ Upload returned null!');
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('Upload failed')));
//       }
//     } catch (e) {
//       debugPrint('⚠️ Pick or upload error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error picking or uploading image')),
//       );
//     } finally {
//       if (mounted) {
//         setState(() => _isUploading = false);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: _isUploading ? null : _pickAndUploadImage,
//       child: Container(
//         height: 100,
//         width: 100,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100),
//           color: AppColors.white,
//           image:
//               _imageFile != null
//                   ? DecorationImage(
//                     image: FileImage(_imageFile!),
//                     fit: BoxFit.cover,
//                   )
//                   : null,
//         ),
//         child:
//             _isUploading
//                 ? const Center(child: CircularProgressIndicator())
//                 : (_imageFile == null
//                     ? const Icon(Icons.person, size: 40, color: AppColors.black)
//                     : null),
//       ),
//     );
//   }
// }
