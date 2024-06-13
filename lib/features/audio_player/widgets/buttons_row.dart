import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextButton.icon(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.blackColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                ),
              ),
              icon: const Icon(
                Icons.slow_motion_video,
                color: AppColors.medGreyColor,
              ),
              label: const Text(
                "Play",
                style: TextStyle(color: AppColors.medGreyColor),
              )),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.lightGreyColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                ),
              ),
              icon: const Icon(
                Icons.shuffle,
                color: AppColors.blackColor,
              ),
              label: const Text(
                "Shuffle",
                style: TextStyle(color: AppColors.blackColor),
              )),
        ),
      ],
    );
  }
}
