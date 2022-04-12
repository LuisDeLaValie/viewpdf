import 'dart:io';
import 'package:flutter/material.dart';

import 'package:file_manager/file_manager.dart';

class Directoriso extends StatefulWidget {
  Directoriso({Key? key}) : super(key: key);

  @override
  State<Directoriso> createState() => _DirectorisoState();
}

class _DirectorisoState extends State<Directoriso> {
  final FileManagerController controller = FileManagerController();

  final String url = "/data/user/0/com.TDTxLe.viewPDF";
  // D/PDF_RENDER( 6172): OpenFileDocument. File: /data/user/0/com.TDTxLe.viewPDF/app_flutter/1647903294671-g]og/00414_libro_blanco.pdf
  @override
  void initState() {
    super.initState();

    controller.openDirectory(Directory(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FileManager(
        controller: controller,
        builder: (context, snapshot) {
          final List<FileSystemEntity> entities = snapshot;
          return ListView.builder(
            itemCount: entities.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: FileManager.isFile(entities[index])
                      ? Icon(Icons.feed_outlined)
                      : Icon(Icons.folder),
                  title: Text(FileManager.basename(entities[index])),
                  onTap: () {
                    if (FileManager.isDirectory(entities[index])) {
                      controller
                          .openDirectory(entities[index]); // open directory
                    } else {
                      // Perform file-related tasks.
                    }
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        onPressed: () {
          controller.openDirectory(Directory(url));
        },
      ),
    );
  }
}
