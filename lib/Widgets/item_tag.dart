import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Services/Font_Size.dart';

class ItemTag extends StatelessWidget {
  final String promoTitle;
  final Function onPressed;
  final FontSizeObserver fontSizeObserver = FontSizeObserver();

  ItemTag({Key key, this.promoTitle, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        //border: Border.all(style: BorderStyle.solid, color: Colors.green),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              margin: EdgeInsets.only(
                left: 12,
              ),
              child: Text(
                promoTitle,
                style: GoogleFonts.montserrat(
                  color: Colors.black54,
                  fontSize: fontSizeObserver.getFontSize(context, "PromoTag"),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: RawMaterialButton(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
              ),
              constraints: BoxConstraints.tightFor(height: 20, width: 20),
              onPressed: onPressed,
              child: Icon(
                Icons.close,
                size: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
