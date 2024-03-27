import 'package:excel_link/permissionController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'downloadController.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PermissionScreen(),
    );
  }
}

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PermissionController _permissionController =
    Get.put(PermissionController());
    final DownloadController _downloadController =
    Get.put(DownloadController());
    final DownloadController _excelDownloadController =
    Get.put(DownloadController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Files'),
      ),
      body: Center(
        child: Obx(
              () {
            final permissionStatus =
                _permissionController.permissionStatus.value;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Storage Permission Status: \n $permissionStatus',
                  style: TextStyle(fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (permissionStatus == PermissionStatus.granted) {
                      String pptUrl =
                          "https://beta-reconnect.colliersasia.com/Documents/Japan/DealReport/Reports/Test Company mobile app_26032024094552.pptx";
                      String pptSavePath = "test_file.xlsx";

                      _downloadController.downloadFile(
                          pptUrl, pptSavePath, context);
                    } else {
                      await _permissionController.requestStoragePermission();
                    }
                  },
                  child: Text('Download PPT'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (permissionStatus == PermissionStatus.granted) {
                      String excelUrl =
                          "https://example.com/path/to/excel_file.xlsx";
                      String excelSavePath = "excel_file.xlsx";

                      _excelDownloadController.downloadFile(
                          excelUrl, excelSavePath, context);
                    } else {
                      await _permissionController.requestStoragePermission();
                    }
                  },
                  child: Text('Download Excel'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
