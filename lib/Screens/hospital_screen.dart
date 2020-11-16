import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medkube/Widgets/hospital_card.dart';
import 'package:medkube/constants.dart';
import 'package:medkube/extras.dart';

class HospitalScreen extends StatefulWidget {
  static String id = "hospScreen";
  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  CollectionReference hospitalRef =
      FirebaseFirestore.instance.collection("hospitals");
  var hospitalData;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getData();
  }

  Future getData() async {
    await hospitalRef.get().then((value) {
      value.docs.forEach((element) {
        print(element);

        listViewItems.add(HospitalCard(
          address: element["address"],
          hospName: element["hospital"],
          phoneNumber: element["phone"],
        ));
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  List<Widget> listViewItems = [
    Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("images/hospital.png"),
            height: 40,
            width: 40,
          ),
          SizedBox(width: 8.0),
          Container(
            child: Center(
                child: Text("Hospitals",
                    style: kAlertBoxText.copyWith(fontSize: 28.0))),
          )
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: isLoading
            ? SpinKitWave(
                type: SpinKitWaveType.start,
                color: Colors.blue,
                size: 40.0,
              )
            : ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(
                  children: listViewItems,
                ),
              ),
      ),
    );
  }
}
