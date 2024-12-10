import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';

import '../../../controller/services.dart';
import '../../../models/photo_model.dart';
import '../../../widgets/cat_bloack.dart';
import '../full_view_img/full_view_img.dart';

class CategoryScreen extends StatefulWidget {
  String catName;
  String catImgUrl;

  CategoryScreen({super.key, required this.catImgUrl, required this.catName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<PhotoModel> categoryResults = [];
  bool isLoading = true;
  Future? apiCall;

  @override
  void initState() {
    super.initState();
    apiCall = getData();
  }

  Future getData() async {
    categoryResults = await Services().searchWallpapers(widget.catName);
    setState(() => isLoading = false);
    return categoryResults;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Wallpaper App"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(children: [
                    Image.network(height: 150, width: MediaQuery.of(context).size.width, fit: BoxFit.cover, widget.catImgUrl),
                    Container(color: Colors.black38, height: 150, width: MediaQuery.of(context).size.width),
                    Positioned(
                        left: 120,
                        top: 40,
                        child: Column(children: [
                          const Text("Category", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Colors.white)),
                          Text(widget.catName, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white))
                        ]))
                  ]))),
          FutureBuilder(
              future: apiCall,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: GridView.builder(
                          // shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 13, mainAxisSpacing: 10, mainAxisExtent: 400),
                          itemCount: categoryResults[0].photos!.length,
                          itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(color: Colors.amberAccent, borderRadius: BorderRadius.circular(18)),
                              height: 500,
                              width: 50,
                              child: InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullViewImg(
                                            imgUrl: categoryResults.isEmpty
                                                ? "https://images.pexels.com/photos/3264504/pexels-photo-3264504.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
                                                : categoryResults[0].photos![index].src!.original!))),
                                child:
                                    ClipRRect(borderRadius: BorderRadius.circular(18), child: Image.network(fit: BoxFit.cover, categoryResults[0].photos![index].src!.original!)),
                              ))));
                } else {
                  return const Center(child: SpinKitThreeBounce(color: Color(0xff2455EF), size: 50.0));
                }
              })
        ])));
  }
}
