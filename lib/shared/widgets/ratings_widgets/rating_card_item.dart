import 'package:flutter/material.dart';
import 'package:mofatesh/shared/widgets/reusable_text_button.dart';

import '../../../models/ratings_model.dart';

class RatingCardItem extends StatelessWidget {
  final Data data;
  // final Function checkFun;
  // final bool checkVal;
  final Function? titlePressed;

  RatingCardItem({
    required this.data,
    // required this.checkFun,
    // required this.checkVal,
    required this.titlePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Card(
        margin: const EdgeInsets.all(12),
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (val) {},
                    ),
                    Text(
                      data.category!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: reusableTextButton(
                        text: data.title!,
                        function: () => titlePressed,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.change_circle_outlined,
                      size: 30,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
              Text(
                data.detail!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
