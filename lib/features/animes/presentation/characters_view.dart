import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:anime_slayer/features/animes/presentation/anime_detaills_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'character_card.dart';

class CharactersView extends StatelessWidget {
  const CharactersView(this.characters, {super.key});

  final List<CharacterModel> characters;
  @override
  Widget build(BuildContext context) {
    final mainCharacters = characters
        .where((element) => element.role == CharacterType.main)
        .toList();
    final supportCharacters = characters
        .where((element) => element.role == CharacterType.support)
        .toList();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: characters.isEmpty
          ? const Center(
              child: Text('لا يوجد شخصيات'),
            )
          : ListView(
              children: [
                Text('الشخصيات الرئيسية',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    )),
                5.verticalSpace,
                SizedBox(
                  height: 150.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mainCharacters.length,
                    itemBuilder: (context, index) {
                      return CharacterCard(
                        character: mainCharacters[index],
                      );
                    },
                  ),
                ),
                Text('الشخصيات الداعمة',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    )),
                5.verticalSpace,
                SizedBox(
                  height: 200.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: supportCharacters.length,
                    itemBuilder: (context, index) {
                      return CharacterCard(
                        character: supportCharacters[index],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
