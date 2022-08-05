import 'package:flutter/material.dart';
import 'package:mofatesh/modules/drawer_modules/rating_create_screen.dart';
import 'package:mofatesh/shared/methods.dart';
import 'package:mofatesh/shared/widgets/reusable_drawer_item.dart';

class HomeLayOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: SafeArea(
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: reusableDrawerItem(
                  context: context,
                  title: 'انشاء تقييم',
                  onTap: () {
                    // RatingsCubit.get(context).getRatingsData();
                    Navigator.pop(context);
                    navigateTo(
                      widget: RatingCreateScreen(),
                      context: context,
                    );

                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: const SafeArea(
        child: Center(
          child: Image(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
