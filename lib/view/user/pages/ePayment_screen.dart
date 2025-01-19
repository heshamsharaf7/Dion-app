import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';

import '../../../../util/app_color.dart';
import 'package:dionapplication/util/images.dart';

class ePaymentScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items = List.generate(4, (index) {
    return {
      'name': 'Item $index',
      'images': [
        Images.cash,
        Images.jwali,
        Images.yWallet,
        Images.kurimi,
      ],
      'texts': [
        'كاش',
        'جوالي',
        'يمن والت',
        'كريمي',
      ],
    };
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: 'تسديد الديون'),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(items.length, (index) {
            return GridItem(
              itemData: items[index],
              itemIndex: index,
            );
          }),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final Map<String, dynamic> itemData;
  final int itemIndex;

  const GridItem({
    Key? key,
    required this.itemData,
    required this.itemIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images = itemData['images'] ?? [];
    List<String> texts = itemData['texts'] ?? [];
    String itemName = itemData['name'] ?? '';

    return InkWell(
      onTap: () {
        print('Item $itemIndex clicked');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColor.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (itemIndex < images.length)
                Image.asset(
                  images[itemIndex],
                  width: 100,
                  height: 100,
                ),
              SizedBox(height: 8),
              if (itemIndex < texts.length)
                Text(
                  texts[itemIndex],
                  style: robotoHuge,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
