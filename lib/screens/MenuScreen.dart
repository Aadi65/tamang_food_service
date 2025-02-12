import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu")),
      // body: ListView(
      //   children: const [
      //     ListTile(
      //       leading: Icon(Icons.fastfood),
      //       title: Text("Food Menu"),
      //       subtitle: Text("Explore our delicious menu"),
      //       trailing: Icon(Icons.arrow_forward_ios),
      //     ),
      //     ListTile(
      //       leading: Icon(Icons.local_offer),
      //       title: Text("Offers & Discounts"),
      //       subtitle: Text("Check out the latest deals"),
      //       trailing: Icon(Icons.arrow_forward_ios),
      //     ),
      //     ListTile(
      //       leading: Icon(Icons.contact_support),
      //       title: Text("Customer Support"),
      //       subtitle: Text("Get help with orders"),
      //       trailing: Icon(Icons.arrow_forward_ios),
      //     ),
      //   ],
      // ),
    );
  }
}
