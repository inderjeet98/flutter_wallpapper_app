import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:like_button/like_button.dart';
import 'package:fl_downloader/fl_downloader.dart';
// import 'package:image_downloader/image_downloader.dart';
// import 'package:open_file/open_file.dart';

class FloatingCustomBottomBar extends StatefulWidget {
  FloatingCustomBottomBar({super.key, required this.url});
  String url;

  @override
  State<FloatingCustomBottomBar> createState() => _FloatingCustomBottomBarState();
}

class _FloatingCustomBottomBarState extends State<FloatingCustomBottomBar> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int progress = 0;
  dynamic downloadId;
  String? status;
  late StreamSubscription progressStream;

  @override
  void initState() {
    super.initState();
    FlDownloader.initialize();
  }

  @override
  void dispose() {
    progressStream.cancel();
    super.dispose();
  }

  imageLoad() {
    progressStream = FlDownloader.progressStream.listen((event) {
      if (event.status == DownloadStatus.successful) {
        debugPrint('event.progress: ${event.progress}');
        setState(() {
          progress = event.progress;
          downloadId = event.downloadId;
          status = event.status.name;
        });
        // This is a way of auto-opening downloaded file right after a download is completed
        FlDownloader.openFile(filePath: event.filePath);
      } else if (event.status == DownloadStatus.running) {
        debugPrint('event.progress: ${event.progress}');
        setState(() {
          progress = event.progress;
          downloadId = event.downloadId;
          status = event.status.name;
        });
      } else if (event.status == DownloadStatus.failed) {
        debugPrint('event: $event');
        setState(() {
          progress = event.progress;
          downloadId = event.downloadId;
          status = event.status.name;
        });
      } else if (event.status == DownloadStatus.paused) {
        debugPrint('Download paused');
        setState(() {
          progress = event.progress;
          downloadId = event.downloadId;
          status = event.status.name;
        });
        Future.delayed(
          const Duration(milliseconds: 250),
          () => FlDownloader.attachDownloadProgress(event.downloadId),
        );
      } else if (event.status == DownloadStatus.pending) {
        debugPrint('Download pending');
        setState(() {
          progress = event.progress;
          downloadId = event.downloadId;
          status = event.status.name;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      decoration: BoxDecoration(color: const Color.fromARGB(74, 255, 255, 255), borderRadius: BorderRadius.circular(18)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LikeButton(
            size: 18,
            isLiked: false,
            likeBuilder: (isLiked) {
              // isLiked = false;
              return isLiked ? const Icon(Icons.bookmark_outlined, size: 18) : const Icon(Icons.bookmark_border_outlined, size: 18);
            },
            bubblesColor: const BubblesColor(dotPrimaryColor: Color.fromARGB(255, 42, 38, 36), dotSecondaryColor: Color.fromARGB(255, 36, 16, 9)),
            onTap: (isLiked) async {
              isLiked = !isLiked;
              return isLiked;
            },
          ),
          Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(38)),
              child: ElevatedButton(onPressed: () => downloadWallpaper(widget.url), child: const Icon(Icons.file_download_outlined, size: 22))),
          LikeButton(
            size: 18,
            isLiked: false,
            likeBuilder: (isLiked) {
              // isLiked = !isLiked;
              return isLiked ? const Icon(Icons.favorite_outlined, size: 18, color: Color.fromARGB(255, 242, 48, 48)) : const Icon(Icons.favorite_border, size: 18);
            },
            bubblesColor: const BubblesColor(dotPrimaryColor: Color(0xFFFF5722), dotSecondaryColor: Color(0xFFFF5722)),
            onTap: (isLiked) async {
              isLiked = !isLiked;
              return isLiked;
            },
          ),
        ],
      ),
    );
  }

  Future<void> downloadWallpaper(url) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Downloading Started...")));
    try {
      final permission = await FlDownloader.requestPermission();
      if (permission == StoragePermissionStatus.granted) {
        await FlDownloader.download(widget.url);
      } else {
        debugPrint('Permission denied =(');
      }
      // var imageId = await ImageDownloader.downloadImage(url);
      // if (imageId == null) {
      //   return;
      // }

      // var fileName = await ImageDownloader.findName(imageId);
      // var filePath = await ImageDownloader.findPath(imageId);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("$fileName Downloaded Sucessfully"), action: SnackBarAction(label: "Open", onPressed: () => OpenFile.open(filePath))));
    } on PlatformException catch (error) {
      print(error);
    }
  }
}
