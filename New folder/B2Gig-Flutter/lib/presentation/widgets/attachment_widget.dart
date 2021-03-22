import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AttachmentWidget extends StatefulWidget {
  @override
  State createState() => new AttachmentWidgetState();
}

class AttachmentWidgetState extends State<AttachmentWidget> {
  final Function onTapPhoto;
  final Function onTapAttachment;
  final picker = ImagePicker();

  AttachmentWidgetState({
    this.onTapPhoto,
    this.onTapAttachment,
  });

  @override
  Widget build(BuildContext context) {
    takePhoto() async {
      // File file;
      // file = await ImagePicker.pickImage(source: ImageSource.camera);
      final clickedPhoto = picker.getImage(source: ImageSource.camera);
    }

    selectFile() async {
      // File file;
      // file = await ImagePicker.pickImage(source: ImageSource.gallery);
      final pickedFile = picker.getImage(source: ImageSource.gallery);
    }

    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.photo, color: Colors.white),
                        iconSize: 35.0,
                      ),
                      Text(
                        "Take Photo",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  // height: 45.0,
                  // minWidth: 250.0,
                  onPressed: () {
                    takePhoto();
                  }),
              SizedBox(height: 20.0),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.attach_file, color: Colors.white),
                        iconSize: 35.0,
                      ),
                      Text(
                        "Attach File",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  // height: 45.0,
                  // minWidth: 250.0,
                  onPressed: () {
                    selectFile();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
