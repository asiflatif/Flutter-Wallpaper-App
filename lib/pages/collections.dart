import 'package:flutter/material.dart';
import 'package:wallpaper/widgets/changeThemeButtonWidget.dart';

class Collections extends StatefulWidget {
  const Collections({Key key}) : super(key: key);

  @override
  _CollectionsState createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ChangeThemeButtonWidget(),),
    );
  }
}
