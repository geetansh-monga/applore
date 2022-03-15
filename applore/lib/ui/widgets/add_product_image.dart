import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddproductImage extends StatefulWidget {
  AddproductImage({
    Key? key,
    required Function(File?) onProductImageAdded,
  })  : _onProductImageAdded = onProductImageAdded,
        super(key: key);

  final Function(File?) _onProductImageAdded;
  @override
  State<AddproductImage> createState() => _AddproductImageState();
}

class _AddproductImageState extends State<AddproductImage> {
  static const _noFileSelected = 'No File Selected';
  UploadTask? task;
  File? imageFile;
  final _imagePicker = ImagePicker();
  XFile? image;

  @override
  void dispose() {
    super.dispose();
    image = null;
  }

  @override
  Widget build(BuildContext context) {
    var fileName =
        imageFile != null ? basename(imageFile!.path) : _noFileSelected;

    return GestureDetector(
      onTap: () async {
        image = await _imagePicker.pickImage(source: ImageSource.gallery);
        if (image == null) {
          imageFile = null;
        } else {
          setState(() {
            imageFile = File(image!.path);
          });
          widget._onProductImageAdded.call(imageFile);
        }
      },
      child: Container(
        height: 120,
        width: 130,
        decoration: BoxDecoration(
            color: Colors.lightBlue, borderRadius: BorderRadius.circular(20)),
        child: imageFile == null
            ? const Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              )
            : Image.file(
                imageFile!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
