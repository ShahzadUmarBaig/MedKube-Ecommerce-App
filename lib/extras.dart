import 'package:flutter/material.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

/*

  File _image;
  final picker = ImagePicker();
  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }


 Align(
                alignment: Alignment.center,
                child: Badge(
                  position: BadgePosition.bottomRight(),
                  badgeContent: GestureDetector(
                    onTap: getImage,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  child: Hero(
                    tag: "ProfPic",
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: _image == null
                          ? AssetImage("images/user.png")
                          : FileImage(_image),
                    ),
                  ),
                  padding: EdgeInsets.all(12),
                ),
              ),
 */
