import 'package:buyer_app/global/global.dart';
import 'package:buyer_app/widgets/my_drawer.dart';
import 'package:flutter/material.dart';


class AppScaffold extends StatefulWidget {
  final Widget body;
  final Widget? bottomSheet;

  final String? title;
  final bool? onDragKeyboardDismiss;

  const AppScaffold({
    Key? key,
    required this.body,
    this.title,
    this.bottomSheet,
    this.onDragKeyboardDismiss,
  }) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  GlobalKey<ScaffoldState>? _key;

  String name = "";
  String userPhoto = "";

  @override
  void initState() {
    super.initState();
    _key ??= GlobalKey();
    // loadUserData();
  }

  // Future loadUserData() async {
  //   IPreference preference = globalGetIt<IPreference>();
  //   name = await preference.getUserName();
  //   userPhoto = await preference.getProfilePhoto();
  //   print('=======usrname:${name}');
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _key,
      bottomSheet: widget.bottomSheet,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green,
                  Colors.green,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )),
        ),
        title:Text(
            widget.title!,
          // "Restaurant Hub",
          style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      drawer: MyDrawer(),
      body: widget.body,
    );
  }

}