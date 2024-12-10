import "package:flutter/material.dart";
import 'package:skeletonizer/skeletonizer.dart';

import '../../../widgets/search_bar.dart';
import '../../../models/photo_model.dart';
import '../../../controller/services.dart';
import '../full_view_img/full_view_img.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  String qry;
  SearchScreen({super.key, required this.qry});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<PhotoModel> searchResults = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    searchResults = await Services().searchWallpapers(widget.qry);
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.qry.isNotEmpty ? widget.qry : "Wallpaper App"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Searchbar(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              height: MediaQuery.of(context).size.height * 0.85 - MediaQuery.of(context).viewPadding.bottom - 40,
              child: Skeletonizer(
                enabled: loading,
                child: GridView.builder(
                    // shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 13, mainAxisSpacing: 10, mainAxisExtent: 400),
                    itemCount: searchResults.isEmpty ? 8 : searchResults[0].photos!.length,
                    itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(color: Colors.amberAccent, borderRadius: BorderRadius.circular(18)),
                          height: 500,
                          width: 50,
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullViewImg(
                                        imgUrl: searchResults.isEmpty
                                            ? "https://images.pexels.com/photos/3264504/pexels-photo-3264504.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
                                            : searchResults[0].photos![index].src!.original!))),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.network(
                                    fit: BoxFit.cover,
                                    searchResults.isEmpty
                                        ? "https://images.pexels.com/photos/3264504/pexels-photo-3264504.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
                                        : searchResults[0].photos![index].src!.original ??
                                            "https://images.pexels.com/photos/3264504/pexels-photo-3264504.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")),
                          ),
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
