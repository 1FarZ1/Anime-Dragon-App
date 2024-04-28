import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({super.key, required this.name, this.value, this.valueChild})
      : assert(value != null || valueChild != null);

  final String name;
  final String? value;
  final Widget? valueChild;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        5.verticalSpace,
        value != null
            ? Text(
                value!,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              )
            : valueChild!,
      ],
    );
  }
}
