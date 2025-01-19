import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/util/images.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_rounded)),
        ),
      ),
      backgroundColor: Colors.blue,
      title: Text(title, style: robotoHugeWhite),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ImageIcon(
            AssetImage(Images.whiteLogo),
            color: Colors.white,
            size: 32,
          ),
        ),
      ],
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
