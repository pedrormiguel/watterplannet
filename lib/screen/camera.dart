import 'dart:io';
import 'package:flutter/material.dart';
import 'package:watterplannet/interfaces/IServicesFirebaseImage.dart';

class SelectePickerPhoto extends StatefulWidget {
  final ServicesFirebaseImage  _servicesFirebaseImage = new ServicesFirebaseImage();

  @override
  _SelectePickerPhotoState createState() => _SelectePickerPhotoState();
}

class _SelectePickerPhotoState extends State<SelectePickerPhoto> {
   File _image;


  Future getImageFromCamera() async {

    File image =  await widget._servicesFirebaseImage.getImageFromCamera();

    setState(() {
      _image = image;
    });

  }

   Future getImageFromGallery() async {

     File image =  await widget._servicesFirebaseImage.getImageFromGallery();

      setState(() {
        _image = image;
      });

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () async {
              await getImageFromCamera();
            },
            tooltip: 'Pick Image',
            child: Icon(Icons.add_a_photo),
          ),
          FloatingActionButton(
            onPressed: () 
            async {
                   var p = await widget._servicesFirebaseImage.getUrl();
                   print(p);
            },
            tooltip: 'Pick Image',
            child: Icon(Icons.present_to_all),
          ),

           FloatingActionButton(
            onPressed: () async {
              await getImageFromGallery();
            },
            tooltip: 'Pick Image',
            child: Icon(Icons.gradient),
          ),

            FloatingActionButton(
            onPressed: () async 
            {
              await widget._servicesFirebaseImage.uploadPicture();
              print("Done");
            },
            tooltip: 'Pick Image',
            child: Icon(Icons.save),
          ),

           
        ],
      ),
    );
  }
}
