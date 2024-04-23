// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_v2/tflite_v2.dart';

// class DetectController extends GetxController {
//   RxBool loading = true.obs;
//   Rx<File?> image = Rx<File?>(null);

//   RxList<dynamic>? output = RxList<dynamic>([]);

//   final picker = ImagePicker();

//   @override
//   void onInit() {
//     super.onInit();
//     loadModel();
//   }

//   Future<void> classifyImage(File? image) async {
//     if (image == null) return;

//     var result = await Tflite.runModelOnImage(
//       path: image.path,
//       numResults: 10,
//       threshold: 0.2,
//       imageMean: 255,
//       imageStd: 255,
//     );

//     output!.assignAll(result?.toList() ?? []);
//     loading.value = false;
//   }

//   Future<void> loadModel() async {
//     // Logika untuk load model
//     await Tflite.loadModel(
//       model: 'assets/model.tflite',
//       labels: 'assets/labels.txt',
//     );
//   }

//   Future<void> pickImage() async {
//     var pickedImage = await picker.pickImage(source: ImageSource.camera);
//     if (pickedImage != null) {
//       image.value = File(pickedImage.path);
//       classifyImage(image.value);
//     }
//   }

//   Future<void> pickGalleryImage() async {
//     var pickedImage = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       image.value = File(pickedImage.path);
//       classifyImage(image.value);
//     }
//   }
// }
import 'package:http_parser/http_parser.dart'; // Import paket http_parser untuk MediaType
import 'package:path/path.dart' as path;
// import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import '../../helper/auth.dart';

class DetectController extends GetxController {
  RxBool loading = true.obs;
  Rx<File?> image = Rx<File?>(null);

  RxList<dynamic>? output = RxList<dynamic>([]);

  final picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadModel();
  }

  Future<void> classifyImage(File? image) async {
    if (image == null) return;

    var result = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 10,
      threshold: 0.2,
      imageMean: 255,
      imageStd: 255,
    );

    output!.assignAll(result?.toList() ?? []);
    loading.value = false;
  }

  Future<void> loadModel() async {
    // Logika untuk load model
    await Tflite.loadModel(
      model: 'assets/model.tflite',
      labels: 'assets/labels.txt',
    );
  }

  Future<void> pickImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image.value = File(pickedImage.path);
      classifyImage(image.value);
    }
  }

  Future<void> pickGalleryImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image.value = File(pickedImage.path);
      classifyImage(image.value);
    }
  }

  // Di dalam DetectController, tambahkan logika untuk menyimpan informasi deteksi ke server
  static final String apiUrl =
      'https://be-ta.vercel.app/user/upload';

  Future<void> saveDetectionResult(
      File? imageFile, List<dynamic>? result) async {
    if (imageFile == null || result == null || result.isEmpty) return;

    try {
      // Get authentication token
      await AuthHelper.fetchAuthToken();
      String authToken = AuthHelper.authToken;

      // Construct the multipart request
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add the image file to the request
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: path.basename(imageFile.path),
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(multipartFile);

      // Add other fields to the request
      request.fields['label'] = getLabelDisplayName(result[0]['label']);
      request.fields['treatment'] = getTreatmentForLabel(result[0]['label']);

      // Set authorization header
      request.headers['Authorization'] = 'Bearer $authToken';

      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        print('Detection result saved successfully.');
      } else {
        print(
            'Failed to save detection result. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred while saving detection result: $error');
    }
  }

  String getTreatmentForLabel(String label) {
    // Implement your logic to get treatment based on the detected label
     switch (label) {
      case 'Tomato___Bacterial_spot':
        return 'Pengendalian penyakit bakteri ini melibatkan praktik sanitasi yang baik, seperti membersihkan peralatan tani dan area tanaman, serta memperhatikan rotasi tanaman. Penggunaan fungisida atau antibiotik juga dapat membantu.';
      case 'Tomato___Early_blight':
        return 
          'Ini disebabkan oleh jamur dan bisa dikelola dengan menggunakan rotasi tanaman, membuang bagian tanaman yang terinfeksi, penggunaan mulsa, dan aplikasi fungisida jika diperlukan.';
      case 'Tomato___Late_blight':
        return 
          'Perlakuan meliputi penggunaan varietas tahan penyakit, praktik sanitasi, rotasi tanaman, dan penggunaan fungisida seperti klorotalonil.';
      case 'Tomato___Leaf_Mold':
        return 
          'Pengendalian mencakup menjaga kelembaban rendah di area tanaman, meningkatkan sirkulasi udara, dan menggunakan fungisida jika infeksi parah.';
      case 'Tomato___Septoria_leaf_spot':
        return 
          'Praktik pengelolaan meliputi penghapusan daun yang terinfeksi, rotasi tanaman, penyiraman tanaman dari bawah, dan penggunaan fungisida.';
      case 'Tomato___Spider_mites Two-spotted_spider_mite':
        return 
          'Pengendalian melibatkan penyemprotan air untuk menghilangkan kutu laba-laba, mempertahankan kelembaban udara yang tinggi, penggunaan predator alami seperti ladybug, dan penggunaan insektisida jika diperlukan.';
      case 'Tomato___Target_Spot':
        return 
          'Menghilangkan daun yang terinfeksi, praktik sanitasi, dan penggunaan fungisida jika diperlukan adalah bagian dari pengelolaan penyakit ini.';
      case 'Tomato___Tomato_Yellow_Leaf_Curl_Virus':
        return 
          'Tanaman yang terinfeksi harus dihapus dan dimusnahkan untuk mencegah penyebaran virus. Penggunaan varietas tahan penyakit dan kontrol serangga vektor juga penting.';
      case 'Tomato___Tomato_mosaic_virus':
        return 
          'Tanaman yang terinfeksi harus dihapus dan dimusnahkan. Pengendalian serangga vektor dan penggunaan varietas yang tahan terhadap virus juga penting.';
      case 'Tomato___healthy':
        return 
          'Prune infected leaves and apply fungicides with chlorothalonil. The signup and login flow of Farmassist is developed using the Bloc library and Firebase Authentication. After a user signs up successfully, the user data will be stored in the data model of Cloud Firestore as shown below:';
      // Tambahkan kasus untuk kategori lainnya sesuai kebutuhan
      // ...
      default:
    return 'Treatment for $label';
    }
  }

   String getLabelDisplayName(String label) {
    switch (label) {
      case 'Tomato___Bacterial_spot':
        return 'Bacterial Spot';
      case 'Tomato___Early_blight':
        return 'Early Blight';
      case 'Tomato___Late_blight':
        return 'Late Blight';
      case 'Tomato___Leaf_Mold':
        return 'Leaf Mold';
      case 'Tomato___Septoria_leaf_spot':
        return 'Septoria Leaf Spot';
      case 'Tomato___Spider_mites Two-spotted_spider_mite':
        return 'Spider Mites';
      case 'Tomato___Target_Spot':
        return 'Target Spot';
      case 'Tomato___Tomato_Yellow_Leaf_Curl_Virus':
        return 'Tomato Yellow Leaf Curl Virus';
      case 'Tomato___Tomato_mosaic_virus':
        return 'Tomato Mosaic Virus';
      case 'Tomato___healthy':
        return 'Tanaman Sehat';
      default:
        return label;
    }
  }
}
