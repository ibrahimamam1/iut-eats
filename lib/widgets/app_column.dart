import 'package:flutter/material.dart';
import 'package:iut_eats/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_test_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimensions.font26),
        SizedBox(height: Dimensions.height10,),
        //comment section
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {return const Icon(Icons.star, color: AppColors.mainColor, size: 15);}),
            ),
            const SizedBox(width: 10,),
            SmallText(text: "4.5"),
            const SizedBox(width: 10,),
            SmallText(text: "1287"),
            const SizedBox(width: 10,),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(height: Dimensions.height20),
        // time and distance
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTestWidget(icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            IconAndTestWidget(icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.mainColor),
            IconAndTestWidget(icon: Icons.access_time_rounded,
                text: "32 min",
                iconColor: AppColors.iconColor2)
          ],
        ),
      ],
    );
  }
}
