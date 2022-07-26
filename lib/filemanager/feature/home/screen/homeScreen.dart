import 'package:filemanager/filemanager/feature/home/screen/screen1.dart';
import 'package:flutter/material.dart';
import 'package:storage_details/storage_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Storage> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    final _data = await StorageDetails.getspace;
    data = _data;
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Screen1()));
  }
}
