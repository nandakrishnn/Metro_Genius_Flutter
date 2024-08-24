import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Ticket Shaped Dialog')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showBookingConfirmationDialog(context);
            },
            child: Text('Show Booking Confirmation'),
          ),
        ),
      ),
    );
  }
}

void showBookingConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ClipPath(
          clipper: TicketClipper(),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/3BmuKVTJjY.json', 
                  width: 200,
                  height: 200,
                  repeat: true,
                ),
                SizedBox(height: 20),
                Text(
                  'Booking Confirmed!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF283891),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, size.height * 0.2);
    path.lineTo(0, size.height * 0.8);
    path.arcToPoint(
      Offset(size.width * 0.1, size.height),
      radius: Radius.circular(10),
      clockwise: false,
    );
    path.lineTo(size.width * 0.9, size.height);
    path.arcToPoint(
      Offset(size.width, size.height * 0.8),
      radius: Radius.circular(10),
      clockwise: false,
    );
    path.lineTo(size.width, size.height * 0.2);
    path.arcToPoint(
      Offset(size.width * 0.9, 0),
      radius: Radius.circular(10),
      clockwise: false,
    );
    path.lineTo(size.width * 0.1, 0);
    path.arcToPoint(
      Offset(0, size.height * 0.2),
      radius: Radius.circular(10),
      clockwise: false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
