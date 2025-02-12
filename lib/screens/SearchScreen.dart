import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     children: [
      //       TextField(
      //         decoration: InputDecoration(
      //           hintText: "Search...",
      //           border: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(10),
      //           ),
      //           prefixIcon: const Icon(Icons.search),
      //         ),
      //       ),
      //       const SizedBox(height: 20),
      //       const Center(
      //         child: Text("Search results will appear here",
      //           style: TextStyle(fontSize: 16, color: Colors.grey)),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
