import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:watterplannet/screen/homeBussines/mainPageBussines.dart';

class ServicesFirebaseImage {
  File _image;
  final picker = ImagePicker();
  String fileName;
  StorageReference firebaseStorageRef = FirebaseStorage.instance.ref();
  StorageTaskSnapshot taskSnapshot;

  Future<File> getImageFromCamera() async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.camera);
    _image = File(pickedFile.path);
    getName(pickedFile);
    return _image;
  }

  Future<File> getImageFromGallery() async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
    getName(pickedFile);
    return _image;
  }

  void getName(PickedFile pickedFile) {
    fileName = basename(pickedFile.path);

    String exten = fileName.substring(fileName.lastIndexOf('.'));

    fileName =
        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}-${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}$exten";
  }

  Future<void> uploadPicture() async {
    StorageUploadTask uploadTask =
        firebaseStorageRef
        .child("images/")
        .child(MainPageBussines.user.email)
        .child(fileName).putFile(_image);

    taskSnapshot = await uploadTask.onComplete;
  }

  Future<String> getUrl() async {
    String url = await firebaseStorageRef
        .child("images/")
        .child(MainPageBussines.user.email)
        .child(fileName).getDownloadURL();

    return url;
  }
}
