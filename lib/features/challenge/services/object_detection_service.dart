import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class ObjectDetectionService {
  final ImageLabeler imageLabeler = ImageLabeler(
    options: ImageLabelerOptions(confidenceThreshold: 0.5),
  );

  Future<String?> detectObject(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);

    final labels = await imageLabeler.processImage(inputImage);

    if (labels.isEmpty) {
      return null;
    }

    for (final label in labels) {
      print('${label.label} : ${label.confidence}');

      final text = label.label.toLowerCase();

      if (text.contains('plant') ||
          text.contains('tree') ||
          text.contains('leaf') ||
          text.contains('flower')) {
        return 'Plant';
      }

      if (text.contains('paper')) {
        return 'Paper';
      }
      if (text.contains('sky')) {
        return 'Sky';
      }

      if (text.contains('mobile')) {
        return 'Mobile';
      }

      if (text.contains('tv') ||
          text.contains('television') ||
          text.contains('monitor') ||
          text.contains('display')) {
        return 'Television';
      }
    }

    return labels.first.label;
  }

  Future<void> dispose() async {
    await imageLabeler.close();
  }
}
