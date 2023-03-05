import 'package:evently/data/model/person_data.dart';
import 'package:evently/theme/colors.dart';
import 'package:evently/theme/decorations.dart';
import 'package:evently/theme/fonts.dart';
import 'package:evently/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class PersonListItem extends StatefulWidget {
  final PersonData personData;
  final bool selectable;

  const PersonListItem(
      {Key? key, required this.personData, this.selectable = true})
      : super(key: key);

  @override
  State<PersonListItem> createState() => _PersonListItemState();
}

class _PersonListItemState extends State<PersonListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.selectable) {
          widget.personData.isSelected = !widget.personData.isSelected;
          setState(() {});
        }
      },
      child: Container(
        decoration: widget.personData.isSelected
            ? AppDecorations.listItemBg.copyWith(color: AppColors.highlight)
            : AppDecorations.listItemBg,
        margin: const EdgeInsets.only(bottom: 25),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        child: Row(
          children: [
            UserAvatar(
              initialChar: widget.personData.name[0],
              color: AppColors.avatarBg,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.personData.name,
                  textAlign: TextAlign.start,
                  style: AppFonts.regular18,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.personData.contactNo,
                  textAlign: TextAlign.start,
                  style: AppFonts.regular14,
                ),
              ],
            ),
            if (widget.personData.isSelected) ...[
              const Spacer(),
              Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: const Icon(
                    Icons.done,
                    size: 16,
                    color: Colors.white,
                  ))
            ]
          ],
        ),
      ),
    );
  }
}
