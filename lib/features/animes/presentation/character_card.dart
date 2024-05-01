import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.character,
  });

  final CharacterModel character;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      width: 100.w,
      child: Column(
        children: [
          Stack(
            children: [
              Opacity(
                opacity: 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    character.imageUrl,
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ...character.name.split(',').map((e) {
                          return Text(
                            e,
                            style: TextStyle(
                              color: Colors.white,
                              shadows: const [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                )
                              ],
                              fontSize: 13.sp,
                            ),
                            textAlign: TextAlign.left,
                          );
                        }),
                      ],
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
