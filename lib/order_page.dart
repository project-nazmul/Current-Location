import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:location_project/home_page.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async{
                    Location location = Location();
                    bool serviceEnabled = await location.serviceEnabled();
                    if (!serviceEnabled) {
                      serviceEnabled = await location.requestService();
                    }
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(),));
                  },
                  child: Text("Order")
              ),
            ],
          )
        ],
      ),
    );
  }
}
