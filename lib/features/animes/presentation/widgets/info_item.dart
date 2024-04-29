import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoItem extends StatelessWidget {
  const InfoItem(
      {super.key,
      required this.name,
      this.value,
      this.valueChild,
      this.haveConstrainedDim = false})
      : assert(value != null || valueChild != null);

  final String name;
  final String? value;
  final Widget? valueChild;
  final bool haveConstrainedDim;

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
            ? SizedBox(
                width: haveConstrainedDim ? 0.5.sw : null,
                child: Text(
                  value!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : valueChild!,
      ],
    );
  }
}
