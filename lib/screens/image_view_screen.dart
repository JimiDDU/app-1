import 'package:flutter/material.dart';
import 'package:grocery_onlineapp/models/businessLayer/baseRoute.dart';

class ImageViewScreen extends BaseRoute {
  final String url;
  ImageViewScreen({a, o, this.url}) : super(a: a, o: o, r: 'ImageViewScreen');

  @override
  _ImageDetilsScreenState createState() => _ImageDetilsScreenState(this.url);
}

class _ImageDetilsScreenState extends BaseRouteState {
  String url;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isReadyToCheckOut = false;
  _ImageDetilsScreenState(this.url) : super();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null;
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(),
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(url)),
              )),
        ));
  }

  @override
  void initState() {
    super.initState();
  }
}
