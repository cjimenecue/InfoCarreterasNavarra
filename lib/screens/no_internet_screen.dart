import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "No hay conexión a internet",
                style: TextStyle(color: Colors.blue, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50),
            Icon(
              Icons.wifi_off,
              size: 60,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
