import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImageContainer extends StatefulWidget {
  const AddImageContainer({this.onPickImage});

  final Function(File) onPickImage;

  @override
  _AddImageContainerState createState() => _AddImageContainerState();
}

class _AddImageContainerState extends State<AddImageContainer> {
  File _image;

  Future<void> _getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() => _image = image);
    widget.onPickImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: _getImage,
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 200,
          height: 200,
          child: _image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(Icons.image, size: 56),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Clique aqui para adicionar uma imagem',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              : Image.file(_image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
