// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// // import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:penoft_machine_test/gen/assets.gen.dart';
// import 'package:penoft_machine_test/shared/constants/colors.dart';
// import 'package:penoft_machine_test/shared/constants/typography.dart';
// import 'package:penoft_machine_test/shared/enum/enum.dart';
// import 'package:penoft_machine_test/shared/extension/print.dart';
// import 'package:penoft_machine_test/shared/extension/square.dart';
// import 'package:penoft_machine_test/shared/extension/string.dart';
// import 'package:path_provider/path_provider.dart';

// // class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
// //   @override
// //   (int, int)? get data => (2, 3);

// //   @override
// //   String get name => '2x3 (customized)';
// // }

// class AppProfilePicker extends StatefulWidget {
//   const AppProfilePicker({
//     super.key,
//     this.width,
//     this.height,
//     this.image,
//     required this.onFileChange,
//     this.pickerType = const [AppFilePickType.camera, AppFilePickType.doc],
//   });
//   final double? width;
//   final double? height;
//   final XFile? image;
//   final List<AppFilePickType> pickerType;

//   final Function(XFile? file) onFileChange;
//   @override
//   State<AppProfilePicker> createState() => _AppProfilePickerState();
// }

// class _AppProfilePickerState extends State<AppProfilePicker> {
//   XFile? selectedImage;
//   final ImagePicker _picker = ImagePicker();
//   @override
//   void initState() {
//     selectedImage = widget.image;
//     super.initState();
//   }

//   // Image compression helper method
//   Future<File?> _compressImage(XFile image) async {
//     try {
//       final originalFile = File(image.path);
//       final originalSizeInBytes = await originalFile.length();
//       final originalSizeInKB = (originalSizeInBytes / 1024).toStringAsFixed(2);
//       final originalSizeInMB =
//           (originalSizeInBytes / (1024 * 1024)).toStringAsFixed(2);
//       devPrintSuccess(
//           "🖼️ Original image size: $originalSizeInKB KB ($originalSizeInMB MB)");
//       final tempDir = await getTemporaryDirectory();
//       final targetPath =
//           '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
//       final result = await FlutterImageCompress.compressAndGetFile(
//         image.path,
//         targetPath,
//         quality: 70,
//         minWidth: 1024,
//         minHeight: 1024,
//       );
//       if (result != null) {
//         final compressedFile = File(result.path);
//         final compressedSizeInBytes = await compressedFile.length();
//         final compressedSizeInKB =
//             (compressedSizeInBytes / 1024).toStringAsFixed(2);
//         final compressedSizeInMB =
//             (compressedSizeInBytes / (1024 * 1024)).toStringAsFixed(2);
//         final compressionRatio =
//             ((originalSizeInBytes - compressedSizeInBytes) /
//                     originalSizeInBytes *
//                     100)
//                 .toStringAsFixed(1);
//         devPrintSuccess(
//             "🖼️ Compressed image size: $compressedSizeInKB KB ($compressedSizeInMB MB)");
//         devPrintSuccess("🖼️ Compression ratio: $compressionRatio% smaller");
//         return compressedFile;
//       }
//       return null;
//     } catch (e) {
//       devPrintSuccess("Image compression error: $e");
//       return null;
//     }
//   }

//   // // Image cropping helper method
//   // Future<XFile?> _cropImage(XFile image) async {
//   //   try {
//   //     final CroppedFile? cropped = await ImageCropper().cropImage(
//   //       sourcePath: image.path,
//   //       compressFormat: ImageCompressFormat.jpg,
//   //       uiSettings: [
//   //         AndroidUiSettings(
//   //           toolbarTitle: 'Crop Image',
//   //           toolbarWidgetColor: Colors.white,
//   //           toolbarColor: Colors.black,
//   //           statusBarColor: Colors.black,
//   //           lockAspectRatio: false,
//   //           hideBottomControls: false,
//   //           showCropGrid: true,
//   //           initAspectRatio: CropAspectRatioPreset.original,
//   //           aspectRatioPresets: [
//   //             CropAspectRatioPreset.original,
//   //             CropAspectRatioPreset.square,
//   //           ],
//   //         ),
//   //         IOSUiSettings(
//   //           title: 'Crop Image',

//   //           // aspectRatioLockEnabled: false,
//   //           aspectRatioPresets: [
//   //             CropAspectRatioPreset.original,
//   //             CropAspectRatioPreset.square,
//   //             // CropAspectRatioPresetCustom(),
//   //           ],
//   //         ),
//   //       ],
//   //     );
//   //     if (cropped == null) {
//   //       return null;
//   //     }
//   //     return XFile(cropped.path);
//   //   } catch (e) {
//   //     devPrintSuccess("Image cropping error: $e");
//   //     return null;
//   //   }
//   // }

//   // Future<void> _pickFromCamera() async {
//   //   final image = await _picker.pickImage(source: ImageSource.camera);
//   //   if (image == null) return;

//   //   final XFile? cropped = await _cropImage(image);
//   //   if (cropped == null) return;

//   //   try {
//   //     final file = File(cropped.path);
//   //     final sizeInBytes = await file.length();
//   //     final sizeInKB = (sizeInBytes / 1024).toStringAsFixed(2);
//   //     devPrintSuccess("📷 Cropped image size: $sizeInKB KB");
//   //     if (sizeInBytes > 300 * 1024) {
//   //       final compressedFile = await _compressImage(cropped);
//   //       if (compressedFile != null) {
//   //         setState(() => selectedImage = XFile(compressedFile.path));
//   //         widget.onFileChange(selectedImage);
//   //         return;
//   //       }
//   //     }
//   //     setState(() => selectedImage = cropped);
//   //     widget.onFileChange(selectedImage);
//   //   } catch (e) {
//   //     setState(() => selectedImage = cropped);
//   //     widget.onFileChange(selectedImage);
//   //   }
//   // }

//   // Future<void> _pickFromGallery() async {
//   //   var file = await FilePicker.platform.pickFiles(
//   //     allowMultiple: false,
//   //     type: FileType.image,
//   //   );
//   //   if (file == null) return;

//   //   var pickedPath = file.files.first.path!;
//   //   final image = XFile(pickedPath);

//   //   final XFile? cropped = await _cropImage(image);
//   //   if (cropped == null) return;

//   //   try {
//   //     final sizeInBytes = await cropped.length();
//   //     final sizeInKB = (sizeInBytes / 1024).toStringAsFixed(2);
//   //     devPrintSuccess("📂 Cropped file size: $sizeInKB KB");
//   //     if (sizeInBytes > 300 * 1024) {
//   //       final compressedFile = await _compressImage(cropped);
//   //       if (compressedFile != null) {
//   //         setState(() => selectedImage = XFile(compressedFile.path));
//   //         widget.onFileChange(selectedImage);
//   //         return;
//   //       }
//   //     }
//   //     setState(() => selectedImage = cropped);
//   //     widget.onFileChange(selectedImage);
//   //   } catch (e) {
//   //     setState(() => selectedImage = cropped);
//   //     widget.onFileChange(selectedImage);
//   //   }
//   // }
// Future<void> _pickFromCamera() async {
//   final image = await _picker.pickImage(source: ImageSource.camera);
//   if (image == null) return;

//   // ❌ Skip cropping on web
//   final XFile cropped = image;

//   try {
//     final file = File(cropped.path);
//     final sizeInBytes = await file.length();
//     final sizeInKB = (sizeInBytes / 1024).toStringAsFixed(2);
//     devPrintSuccess("📷 Image size: $sizeInKB KB");

//     if (sizeInBytes > 300 * 1024) {
//       final compressedFile = await _compressImage(cropped);
//       if (compressedFile != null) {
//         setState(() => selectedImage = XFile(compressedFile.path));
//         widget.onFileChange(selectedImage);
//         return;
//       }
//     }

//     setState(() => selectedImage = cropped);
//     widget.onFileChange(selectedImage);
//   } catch (e) {
//     setState(() => selectedImage = cropped);
//     widget.onFileChange(selectedImage);
//   }
// }

// Future<void> _pickFromGallery() async {
//   try {
//     // Request the file with bytes too (safe fallback when path is null)
//     final result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.image,
//       withData: true, // <-- important: lets you get bytes if path is null
//     );
//     if (result == null) return;

//     final picked = result.files.first;

//     // If there's a direct filesystem path use it; otherwise write bytes to temp file.
//     String filePath;
//     if (picked.path != null && picked.path!.isNotEmpty) {
//       filePath = picked.path!;
//     } else if (picked.bytes != null && picked.bytes!.isNotEmpty) {
//       final tempDir = await getTemporaryDirectory();
//       final safeName =
//           'picked_${DateTime.now().millisecondsSinceEpoch}.${picked.extension ?? 'jpg'}';
//       final tempFile = File('${tempDir.path}/$safeName');
//       await tempFile.writeAsBytes(picked.bytes!, flush: true);
//       filePath = tempFile.path;
//     } else {
//       // nothing to work with
//       devPrintSuccess('Picked image has no path and no bytes — abort');
//       return;
//     }

//     final image = XFile(filePath);

//     // Now safe to use File(image.path)
//     final file = File(image.path);
//     final sizeInBytes = await file.length();
//     final sizeInKB = (sizeInBytes / 1024).toStringAsFixed(2);
//     devPrintSuccess("📂 File size: $sizeInKB KB (path: ${image.path})");

//     if (sizeInBytes > 300 * 1024) {
//       final compressedFile = await _compressImage(image);
//       if (compressedFile != null) {
//         setState(() => selectedImage = XFile(compressedFile.path));
//         widget.onFileChange(selectedImage);
//         return;
//       }
//     }

//     setState(() => selectedImage = image);
//     widget.onFileChange(selectedImage);
//   } catch (e, st) {
//     devPrintSuccess("Gallery pick error: $e\n$st");
//     // fail gracefully if anything goes wrong
//   }
// }

//   void _clearImage() {
//     setState(() => selectedImage = null);
//     widget.onFileChange(null);
//   }

//   void _showPickerOptions(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           title: Text('Select an Option',
//               style: AppTypography.style14W500
//                   .copyWith(color: AppColors.neutral900)),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: Text(
//                   'Choose from Gallery',
//                   style: AppTypography.style14W500
//                       .copyWith(color: AppColors.neutral900),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _pickFromGallery();
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: Text('Take Photo',
//                     style: AppTypography.style14W500
//                         .copyWith(color: AppColors.neutral900)),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _pickFromCamera();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void onTap(BuildContext context) {
//     if (widget.pickerType.length > 1) {
//       _showPickerOptions(context);
//     } else {
//       if (widget.pickerType.contains(AppFilePickType.camera)) {
//         _pickFromCamera();
//       }
//       if (widget.pickerType.contains(AppFilePickType.doc)) {
//         _pickFromGallery();
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => onTap(context),
//       child: Center(
//         child: selectedImage == null
//             ? Container(
//                 width: widget.width ?? 120,
//                 height: widget.height ?? 120,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: AppColors.neutral900, width: 2),
//                 ),
//                 child: Center(
//                   child: Assets.svg.backArrow.icon(context, color: AppColors.neutral900)
//                       .square(36),
//                   //  Icon(Icons.add, size: 40, color: Colors.grey),
//                 ),
//               )
//             : Stack(children: [
//                 CircleAvatar(
//                   radius: widget.width ?? 120 / 2,
//                   backgroundImage: (selectedImage!.path.startsWith('https'))
//                       ? NetworkImage(selectedImage!.path)
//                       : FileImage(
//                           File(selectedImage!.path),
//                         ),
//                 ),
//                 Positioned(
//                   top: 2,
//                   right: 2,
//                   child: InkWell(
//                     onTap: _clearImage,
//                     child: CircleAvatar(
//                       radius: 12,
//                       backgroundColor: AppColors.neutral900,
//                       child: Assets.svg.backArrow
//                           .icon(context, color: AppColors.neutral900)
//                           .square(16),
//                     ),
//                   ),
//                 )
//               ]),
//       ),
//     );
//   }
// }
/*
{
 "message": "Subjects fetched successfully.",
 "data": [
{
"subject": "Mathematics",
"icon": "
https://machinetest.flutter.penoft.com/uploads/subject/icon-1",
"main-color": "#FF6773",
"gradient-color": "#FE8B6E"
},
{
"subject": "Architecture",
"icon": "
https://machinetest.flutter.penoft.com/uploads/subject/icon-2",
"main-color": "#0980B8",
"gradient-color": "#61C2D2"
},
{
"subject": "Chemistry",
"icon": "
https://machinetest.flutter.penoft.com/uploads/subject/icon-1",
"main-color": "#8E44AD",
"gradient-color": "#C39BD3"
},
{
"subject": "Physics",
"icon": "
https://machinetest.flutter.penoft.com/uploads/subject/icon-2",
"main-color": "#27AE60",
"gradient-color": "#7DCEA0"
}
]
}
*/

var courses = {
  "message": "Courses fetched successfully.",
  "data": [
    {
      "title": "JavaScript for Modern Web Development",
      "author": "Robert Fox",
      "duration": "3 hr",
      "price": "10.99",
      "originalPrice": "32",
      "rating": 4.5,
      "reviews": 2980,
      "tag": "Top Author",
      "image":
          "https://machinetest.flutter.penoft.com/uploads/course/course1.png"
    },
    {
      "title": "Python Programming for Data Analysis",
      "author": "Eleanor Pena",
      "duration": "3 hr",
      "price": "10.99",
      "originalPrice": "32",
      "rating": 4.5,
      "reviews": 2980,
      "tag": "Top Author",
      "image":
          "https://machinetest.flutter.penoft.com/uploads/course/course2.png"
    }
  ]
};
var materials = {
  "message": "Materials fetched successfully.",
  "data": [
    {
      "title": "Premium Gel Pen – Pack of 10",
      "brand": "ClassMate",
      "price": "4.99",
      "originalPrice": "12",
      "rating": 4.5,
      "reviews": 2590,
      "tag": "Top Choice",
      "image":
          "https://machinetest.flutter.penoft.com/uploads/material/material-1.png"
    },
    {
      "title": "A5 Spiral Notebook – 200 Pages",
      "brand": "ClassMate",
      "price": "10.99",
      "originalPrice": "32",
      "rating": 4.9,
      "reviews": 8980,
      "tag": "Top Rated",
      "image":
          "https://machinetest.flutter.penoft.com/uploads/material/material-2.png"
    },
    {
      "title": "Ergonomic Adjustable Laptop Stand",
      "brand": "TechMate",
      "price": "10.99",
      "originalPrice": "32",
      "rating": 4.5,
      "reviews": 2980,
      "tag": "Students Pick",
      "image":
          "https://machinetest.flutter.penoft.com/uploads/material/material-3.png"
    }
  ]
};
