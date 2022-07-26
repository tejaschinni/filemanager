import 'package:filemanager/filemanager/feature/home/screen/fileandFolder.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:storage_details/storage_details.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  List<Storage> data = [];
  var files;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  void _init() async {
    final _data = await StorageDetails.getspace;
    data = _data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final storage = data[index];
          return Column(
            children: [
              Text(storage.path),
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: CircularPercentIndicator(
                    radius: 90,
                    lineWidth: 7.0,
                    percent: (storage.used / storage.total),
                    center: Text(
                        "${((storage.used / storage.total) * 100).floor()}%"),
                    progressColor: Colors.green,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FileAndFolder(),
                      ));
                },
              ),
            ],
          );
        },
      ),
    );
    ;
  }
}
