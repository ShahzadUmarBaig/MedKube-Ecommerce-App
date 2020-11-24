import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HospitalCard extends StatelessWidget {
  final String phoneNumber;
  final String address;
  final String hospName;

  const HospitalCard({Key key, this.phoneNumber, this.address, this.hospName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 8,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 7,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      hospName,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      address,
                      style: GoogleFonts.montserrat(
                          fontSize: 12, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.height / 14,
                width: MediaQuery.of(context).size.width / 8,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Colors.grey[300],
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: RawMaterialButton(
                  onPressed: () {
                    UrlLauncher.launch("tel://$phoneNumber");
                  },
                  child: Column(
                    children: [
                      Expanded(child: Icon(Icons.call, color: Colors.green)),
                      SizedBox(
                        height: 12.0,
                      ),
                      Expanded(
                        child: Text(
                          'Call',
                          style: GoogleFonts.montserrat(
                              color: Colors.green, fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
