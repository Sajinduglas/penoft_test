import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penoft_machine_test/gen/assets.gen.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';
import 'package:penoft_machine_test/shared/enum/enum.dart';
import 'package:penoft_machine_test/shared/extension/print.dart';
import 'package:penoft_machine_test/shared/extension/square.dart';
import 'package:penoft_machine_test/shared/extension/string.dart';
import 'package:path_provider/path_provider.dart';

class AppProfilePicker extends StatefulWidget {
  const AppProfilePicker({
    super.key,
    this.width,
    this.height,
    this.image,
    required this.onFileChange,
    // pickerType removed/unused — camera only now
  });
  final double? width;
  final double? height;
  final XFile? image;

  final Function(XFile? file) onFileChange;
  @override
  State<AppProfilePicker> createState() => _AppProfilePickerState();
}

class _AppProfilePickerState extends State<AppProfilePicker> {
  XFile? selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    selectedImage = widget.image;
    super.initState();
  }

  // Image compression helper method (unchanged)
  Future<File?> _compressImage(XFile image) async {
    try {
      final originalFile = File(image.path);
      final originalSizeInBytes = await originalFile.length();
      final originalSizeInKB = (originalSizeInBytes / 1024).toStringAsFixed(2);
      final originalSizeInMB =
          (originalSizeInBytes / (1024 * 1024)).toStringAsFixed(2);
      devPrintSuccess(
          "🖼️ Original image size: $originalSizeInKB KB ($originalSizeInMB MB)");
      final tempDir = await getTemporaryDirectory();
      final targetPath =
          '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final result = await FlutterImageCompress.compressAndGetFile(
        image.path,
        targetPath,
        quality: 70,
        minWidth: 1024,
        minHeight: 1024,
      );
      if (result != null) {
        final compressedFile = File(result.path);
        final compressedSizeInBytes = await compressedFile.length();
        final compressedSizeInKB =
            (compressedSizeInBytes / 1024).toStringAsFixed(2);
        final compressedSizeInMB =
            (compressedSizeInBytes / (1024 * 1024)).toStringAsFixed(2);
        final compressionRatio =
            ((originalSizeInBytes - compressedSizeInBytes) /
                    originalSizeInBytes *
                    100)
                .toStringAsFixed(1);
        devPrintSuccess(
            "🖼️ Compressed image size: $compressedSizeInKB KB ($compressedSizeInMB MB)");
        devPrintSuccess("🖼️ Compression ratio: $compressionRatio% smaller");
        return compressedFile;
      }
      return null;
    } catch (e) {
      devPrintSuccess("Image compression error: $e");
      return null;
    }
  }

  Future<void> _pickFromCamera() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return;

      final XFile picked = image;

      final file = File(picked.path);
      final sizeInBytes = await file.length();
      final sizeInKB = (sizeInBytes / 1024).toStringAsFixed(2);
      devPrintSuccess("📷 Image size: $sizeInKB KB");

      if (sizeInBytes > 300 * 1024) {
        final compressedFile = await _compressImage(picked);
        if (compressedFile != null) {
          setState(() => selectedImage = XFile(compressedFile.path));
          widget.onFileChange(selectedImage);
          return;
        }
      }

      setState(() => selectedImage = picked);
      widget.onFileChange(selectedImage);
    } catch (e, st) {
      devPrintSuccess("Camera pick error: $e\n$st");
      // fail gracefully: don't crash the UI
    }
  }

  void _clearImage() {
    setState(() => selectedImage = null);
    widget.onFileChange(null);
  }

  void onTap(BuildContext context) {
    _pickFromCamera();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Center(
        child: selectedImage == null
            ? _placeholderCircle()
            : Stack(children: [
                CircleAvatar(
                  radius: (widget.width ?? 120) / 2,
                  backgroundImage: (selectedImage!.path.startsWith('https'))
                      ? NetworkImage(selectedImage!.path)
                      : FileImage(
                          File(selectedImage!.path),
                        ) as ImageProvider,
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: InkWell(
                    onTap: _clearImage,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.backgroundWhite,
                      child: Assets.svg.crossSmall
                          .icon(context, color: AppColors.neutral900)
                          .square(16),
                    ),
                  ),
                )
              ]),
      ),
    );
  }

  Widget _placeholderCircle() {
    final double w = widget.width ?? 120;
    // gradient colors you requested:
    // "#8932EB66" and "#D4B4FE14" interpreted as ARGB ints
    const Color gradientStart = Color(0xFFD4B4FE);
    const Color gradientEnd = Color(0xFFFFFFFF);

    return DottedBorder(
      borderType: BorderType.Circle,
      dashPattern: const [8, 6],
      strokeWidth: 2,
      color: AppColors.primary, // dotted line color — you can change this
      child: Container(
        width: w,
        height: w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [gradientStart, gradientEnd],
          ),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Camera icon (use your svg asset if available)
              Builder(builder: (ctx) {
                try {
                  // if you have Assets.svg.camera, use it
                  return Assets.svg.camera
                      .icon(context, color: AppColors.primary)
                      .square(w * 0.36);
                } catch (_) {
                  // fallback icon if asset isn't available
                  return Icon(
                    Icons.camera_alt,
                    size: w * 0.36,
                    color: AppColors.primary,
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
