import 'dart:convert';

import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../../Provider/image_provider.dart';

import 'package:image_picker/image_picker.dart';


pickImage(ImageSource source) async {

  final ImagePicker _imagePicker = ImagePicker();

  File? _imagefile;
  XFile? _file = await _imagePicker.pickImage(source: source);

  if(_file!=null){

    Uint8List imagebytes = await _file.readAsBytes();
    String _base64 = base64.encode(imagebytes);

    final imagetemppath = File(_file.path);

    print("base64: $_base64");
    print("file path: $imagetemppath");
    _imagefile = imagetemppath;

    return [_imagefile,_base64];
  }
  print("no image selected");

}



