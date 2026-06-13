import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/camera_provider.dart';
import '../providers/challenge_provider.dart';
import '../services/object_detection_service.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  File? imageFile;

  bool isLoading = false;

  final ImagePicker picker = ImagePicker();

  final ObjectDetectionService detector = ObjectDetectionService();

  Future<void> captureImage() async {
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    setState(() {
      isLoading = true;
      imageFile = File(image.path);
    });

    try {
      final label = await detector.detectObject(image.path);

      ref.read(detectedLabelProvider.notifier).state = label;

      if (label != null) {
        final challengeItems = ref.read(challengeProvider);

        for (final item in challengeItems) {
          if (label.toLowerCase().contains(item.name.toLowerCase())) {
            ref.read(challengeProvider.notifier).markCompleted(item.name);
          }
        }
      }

      if (mounted) {
        context.push('/reward');
      }
    } catch (e) {
      debugPrint('Detection Error: $e');

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Detection Failed: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    detector.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = ref.watch(detectedLabelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: imageFile == null
                    ? const Icon(Icons.camera_alt, size: 120)
                    : Image.file(imageFile!),
              ),
            ),

            if (label != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Detected: $label',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : captureImage,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Capture Image'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
