import 'package:flutter/material.dart';

class FontSizeObserver {
  double getFontSize(BuildContext context, String status) {
    double devicePixelRation = MediaQuery.of(context).devicePixelRatio;
    bool smallScreen = devicePixelRation >= 1.5 && devicePixelRation <= 2.5;
    bool bigScreen = devicePixelRation >= 2.6 && devicePixelRation <= 3.5;
    if (status == "Logo") {
      if (smallScreen) {
        return 26.0;
      } else if (bigScreen) {
        return 30;
      }
    } else if (status == "Tagline") {
      if (smallScreen) {
        return 10.5;
      } else if (bigScreen) {
        return 10;
      }
    } else if (status == "HomeCard") {
      if (smallScreen) {
        return 20;
      } else if (bigScreen) {
        return 18;
      }
    } else if (status == "Become") {
      if (smallScreen) {
        return 16;
      } else if (bigScreen) {
        return 19;
      }
    } else if (status == "CartDeliveryLabel") {
      if (smallScreen) {
        return 18;
      } else if (bigScreen) {
        return 16;
      }
    } else if (status == "CartCardProductName") {
      if (smallScreen) {
        return 16;
      } else if (bigScreen) {
        return 14;
      }
    } else if (status == "PromoTag") {
      if (smallScreen) {
        return 16;
      } else if (bigScreen) {
        return 14;
      }
    } else if (status == "PrescriptionLabel") {
      if (smallScreen) {
        return 18;
      } else if (bigScreen) {
        return 16;
      }
    } else if (status == "ContactUs") {
      if (smallScreen) {
        return 24;
      } else if (bigScreen) {
        return 20;
      }
    } else if (status == "WaitingScreen") {
      if (smallScreen) {
        return 24;
      } else if (bigScreen) {
        return 20;
      }
    } else if (status == "OrderDetailProduct") {
      if (smallScreen) {
        return 17;
      } else if (bigScreen) {
        return 15;
      }
    } else if (status == "OrderTicket") {
      if (smallScreen) {
        return 20;
      } else if (bigScreen) {
        return 18;
      }
    } else if (status == "OrderTicketInfo") {
      if (smallScreen) {
        return 16;
      } else if (bigScreen) {
        return 14;
      }
    }

    return 0.0;
  }
}
