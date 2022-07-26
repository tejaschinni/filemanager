import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';

class FileAndFolder extends StatefulWidget {
  const FileAndFolder({Key? key}) : super(key: key);

  @override
  State<FileAndFolder> createState() => _FileAndFolderState();
}

class _FileAndFolderState extends State<FileAndFolder> {
  final FileManagerController controller = FileManagerController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.isRootDirectory()) {
          return true;
        } else {
          controller.goToParentDirectory();
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                //  createFolder(context)
              },
              icon: Icon(Icons.create_new_folder_outlined),
            ),
            IconButton(
              onPressed: () {
                //  sort(context)
              },
              icon: Icon(Icons.sort_rounded),
            ),
            IconButton(
              onPressed: () {
                //selectStorage(context)
              },
              icon: Icon(Icons.sd_storage_rounded),
            )
          ],
          title: ValueListenableBuilder<String>(
            valueListenable: controller.titleNotifier,
            builder: (context, title, _) => Text(title),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              await controller.goToParentDirectory();
            },
          ),
        ),
        body: Container(
          child: FileManager(
              controller: controller,
              builder: (context, snapshot) {
                final List<FileSystemEntity> entities = snapshot;
                return ListView.builder(
                    itemCount: entities.length,
                    itemBuilder: (context, index) {
                      FileSystemEntity entity = entities[index];
                      return Container(
                        child: Card(
                          child: ListTile(
                            leading: FileManager.isFile(entity)
                                ? Icon(Icons.feed_outlined)
                                : Icon(Icons.folder),
                            title: Text(FileManager.basename(entity)),
                            subtitle: subtitle(entity),
                          ),
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }

  Widget subtitle(FileSystemEntity entity) {
    return FutureBuilder<FileStat>(
      future: entity.stat(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (entity is File) {
            int size = snapshot.data!.size;

            return Text(
              "${FileManager.formatBytes(size)}",
            );
          }
          return Text(
            "${snapshot.data!.modified}",
          );
        } else {
          return Text("");
        }
      },
    );
  }
}
