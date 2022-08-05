import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofatesh/cubit/ratings_cubit/cubit.dart';
import 'package:mofatesh/cubit/ratings_cubit/states.dart';
import 'package:mofatesh/modules/drawer_modules/rating_details_screen.dart';
import 'package:mofatesh/shared/methods.dart';
import '../../shared/widgets/reusable_text_button.dart';

class RatingCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingsCubit, RatingsStates>(
      listener: (context, state) {
        if (state is GetRatingDetailsSuccessState) {
          navigateTo(
            widget: RatingsDetailsScreen(
              ratingDetailModel: state.ratingDetailModel,
            ),
            context: context,
          );
        }
      },
      builder: (context, state) {
        var cubit = RatingsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'تقييم',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            centerTitle: true,
          ),
          body: cubit.ratingsModel == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => SizedBox(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Checkbox(
                                    value:
                                        cubit.checkValuesInBaseRating[index] ??
                                            cubit.checkButtonValueInBaseRating,
                                    onChanged: (val) {
                                      cubit.changeCheckValuesInBaseRatings(
                                          index: index, value: val!);
                                    },
                                  ),
                                  Text(
                                    cubit.ratingsModel!.data![index].category!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: state is GetRatingDetailsLoadingState
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : reusableTextButton(
                                            text: cubit.ratingsModel!
                                                .data![index].title!,
                                            function: () {
                                              cubit.templateId = cubit
                                                  .ratingsModel!
                                                  .data![index]
                                                  .id;
                                              print(
                                                  'template id is ${cubit.ratingsModel!.data![index].id!}');
                                              cubit.getRatingDetails(
                                                cubit.ratingsModel!.data![index]
                                                    .id!,
                                              );
                                            }
                                            //     .then(
                                            //   (value) {
                                            //     navigateTo(
                                            //       widget: RatingsDetailsScreen(
                                            //         ratingDetailModel: cubit
                                            //             .ratingDetailModel!,
                                            //         data: cubit.ratingsModel!
                                            //             .data![index],
                                            //       ),
                                            //       context: context,
                                            //     );
                                            //   },
                                            // ),
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
                              cubit.ratingsModel!.data![index].detail!,
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
                  ),
                  itemCount: cubit.ratingsModel!.data!.length,
                ),
        );
      },
    );
  }
}
