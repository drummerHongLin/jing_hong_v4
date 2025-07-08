import 'package:dio/dio.dart' show Dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/local/home/model.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:path_provider/path_provider.dart';

import 'package:jing_hong_v4/utils/download.dart'
    if (dart.library.html) 'dart:html'
    as html;

class CvButton extends StatelessWidget {
  final CvInfo cvInfo;
  final TextStyle? cvStyle;

  const CvButton({super.key, required this.cvInfo, required this.cvStyle});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // 后续增加点击从网络中下载文件功能
      onPressed: () async {
        final msg = await _downloadCv();
        if (msg.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg), duration: Duration(seconds: 2)),
          );
        }
      },
      style: TextButton.styleFrom(
        backgroundColor: AppColors.active,
        shadowColor: AppColors.active,
        elevation: 3,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text("Download CV", style: cvStyle),
      ),
    );
  }

  Future<String> _downloadCv() async {
    String savePath;
    try {
      if (!kIsWeb) {
        final status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          return "Permission denied";
        }
        final dir = await getApplicationDocumentsDirectory();
        savePath = '${dir.path}/cv.pdf';
        final dio = Dio();
        final resp = await dio.download(
          cvInfo.cvUrl, // 替换为你的文件URL
          savePath,
          onReceiveProgress: (received, total) {
            if (total == -1) return;
          },
        );
        if(resp.statusCode == 200){
          OpenFilex.open(savePath);
        }
        
        return "";
      } else {
        // Web download
        savePath = '../cv.pdf';
        html.AnchorElement(
            href:
                cvInfo.cvUrl,
          )
          ..download = savePath
          ..click();
        return "";
      }
    } on Exception catch (e) {
      return "Error downloading CV: ${e.toString()}";
    }
  }
}
