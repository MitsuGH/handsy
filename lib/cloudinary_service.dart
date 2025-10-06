import 'package:cloudinary_public/cloudinary_public.dart';

class CloudinaryService {
  static final CloudinaryPublic cloudinary = CloudinaryPublic(
    'dox7emzgu', // Replace with your cloud name
    'your-upload-preset', // We'll create this in next step
    cache: false,
  );

  // Upload image and return URL
  static Future<String?> uploadImage(String imagePath) async {
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imagePath,
          folder: 'products', // Optional: organize in folders
        ),
      );
      
      return response.secureUrl;
    } catch (e) {
      print('Error uploading to Cloudinary: $e');
      return null;
    }
  }

  // Get optimized image URL
  static String getOptimizedUrl(String publicId, {int width = 800}) {
    return 'https://res.cloudinary.com/your-cloud-name/image/upload/w_$width,c_scale/$publicId';
  }
}