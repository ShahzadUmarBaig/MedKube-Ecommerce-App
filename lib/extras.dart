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

// import 'dart:math';
//
// void main() {
//   print(getRandomString(5)); // 5GKjb
//   print(getRandomString(10)); // LZrJOTBNGA
//   print(getRandomString(15)); // PqokAO1BQBHyJVK
// }
//
// const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
// Random _rnd = Random();
//
// String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
//     length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
