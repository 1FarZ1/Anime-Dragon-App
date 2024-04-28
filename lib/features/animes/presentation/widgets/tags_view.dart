import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagsView extends StatelessWidget {
  const TagsView({
    super.key,
    required this.tags,
  });

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 25.h,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            ...tags.map((e) {
              return Container(
                alignment: Alignment.center,
                width: 50.w,
                margin: EdgeInsets.only(right: 5.w, bottom: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xff3A424D),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  e,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
