import 'package:flutter/material.dart';

import '../views/screens/search/search.dart';

class Searchbar extends StatelessWidget {
  Searchbar({super.key});
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: Colors.black12, border: Border.all(color: Colors.black54), borderRadius: BorderRadius.circular(24)),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(qry: searchController.text.toString()))),
                  icon: const Icon(Icons.search_rounded)),
              suffixIconColor: Colors.black,
              hintText: "Search Wallpapers",
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              border: InputBorder.none),
          onSubmitted: (value) => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(qry: value.toString()))),
        ),
      ),
    );
  }
}
