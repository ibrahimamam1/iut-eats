import 'package:flutter/cupertino.dart';
import 'package:iut_eats/utils/dimensions.dart';
import 'package:iut_eats/widgets/small_text.dart';

class IconAndTestWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndTestWidget({super.key,
  required this.icon,
  required this.text,
    required this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor,size: Dimensions.iconSize24,),
        const SizedBox(width: 5,),
        SmallText(text: text)
      ],
    );
  }
}
