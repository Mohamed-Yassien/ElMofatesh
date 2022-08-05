import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mofatesh/cubit/ratings_cubit/cubit.dart';
import 'package:mofatesh/cubit/ratings_cubit/states.dart';
import 'package:mofatesh/models/rating_detail_model.dart';
import 'package:mofatesh/models/save_data_in_rating_model.dart';
import 'package:mofatesh/shared/widgets/reusable_button.dart';
import 'package:mofatesh/shared/widgets/reusable_text_field.dart';
import 'package:mofatesh/shared/widgets/reusable_toast.dart';

class RatingsDetailsScreen extends StatelessWidget {
  final RatingDetailModel ratingDetailModel;

  RatingsDetailsScreen({
    required this.ratingDetailModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingsCubit, RatingsStates>(
      listener: (context, state) {
        if (state is SaveDataSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = RatingsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                cubit.clearAllData();
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 70,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButton<String>(
                          iconSize: 35,
                          hint: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'اختر الوحدة',
                            ),
                          ),
                          value: cubit.selectedUnit,
                          isExpanded: true,
                          onChanged: (value) {
                            cubit.changeUnitInMenu(value!);
                          },
                          items: List.generate(
                            cubit.unitsModel!.data!.length,
                            (index) => DropdownMenuItem<String>(
                              alignment: AlignmentDirectional.centerEnd,
                              value: cubit
                                  .unitsModel!.data![index].buildingNumber!,
                              child: Text(
                                cubit.unitsModel!.data![index].buildingNumber!,
                              ),
                              onTap: () {
                                cubit.unitId =
                                    cubit.unitsModel!.data![index].id!;
                                print('unit id is${cubit.unitId}');
                                cubit.getUnitMembers(
                                  cubit.unitsModel!.data![index].id!,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 70,
                        child: DropdownButton<String>(
                          iconSize: 35,
                          hint: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'اختر الشركة',
                            ),
                          ),
                          value: cubit.selectedCompany,
                          isExpanded: true,
                          onChanged: (value) {
                            cubit.changeCompanyInMenu(value!);
                          },
                          items: List.generate(
                            cubit.companyModel!.data!.length,
                            (index) => DropdownMenuItem<String>(
                              alignment: AlignmentDirectional.centerEnd,
                              value:
                                  cubit.companyModel!.data![index].companyName!,
                              child: Text(
                                cubit.companyModel!.data![index].companyName!,
                              ),
                              onTap: () {
                                cubit.companyId =
                                    cubit.companyModel!.data![index].id!;
                                print('company id is${cubit.companyId}');
                              },
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 24,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                ratingDetailModel
                                    .questions![cubit.index].question!,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              if (ratingDetailModel
                                      .questions![cubit.index].answerType ==
                                  '0')
                                // TextFormField(
                                //   controller: cubit.answerController,
                                //   // decoration:  const InputDecoration(
                                //   //   hintText: 'type',
                                //   // ),
                                //   //style: GoogleFonts.cairo(),
                                //   onChanged: (val) {
                                //     cubit.addChooseAnswerToMap(
                                //         cubit.index, val, '0');
                                //     cubit.answerController.text = val;
                                //     print(cubit.choosesMap[cubit.index]);
                                //   },
                                //   // textDirection: TextDirection.rtl,
                                // ),
                                ReusableTextField(
                                  onChange: (val) {
                                    cubit.addChooseAnswerToMap(
                                      cubit.index,
                                      val,
                                      '0',
                                    );
                                    // cubit.answerController.text = val;
                                    print(cubit.choosesMap[cubit.index]);
                                  },
                                  inRating: true,
                                  controller: cubit.answerController,
                                  textLabel: 'ضع اجابتك هنا',
                                  validate: (val) {},
                                  type: TextInputType.text,
                                ),
                              if (ratingDetailModel
                                      .questions![cubit.index].answerType ==
                                  '1')
                                Column(
                                  children: [
                                    Row(
                                      children: List.generate(
                                        ratingDetailModel
                                            .questions![cubit.index]
                                            .answers!
                                            .length,
                                        (index2) => Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Radio<int?>(
                                                  value: ratingDetailModel
                                                      .questions![cubit.index]
                                                      .answers![index2]
                                                      .value,
                                                  groupValue:
                                                      cubit.radioGroupValue,
                                                  onChanged: (val) {
                                                    // cubit.changeRadioSelected(
                                                    //   val!,
                                                    // );
                                                    cubit.addChooseAnswerToMap(
                                                      cubit.index,
                                                      val,
                                                      '1',
                                                    );
                                                    print(cubit.choosesMap[
                                                        cubit.index]);
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  ratingDetailModel
                                                      .questions![cubit.index]
                                                      .answers![index2]
                                                      .label!,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (ratingDetailModel
                                      .questions![cubit.index].answerType ==
                                  '2')
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: List.generate(
                                    ratingDetailModel.questions![cubit.index]
                                        .answers!.length,
                                    (index2) => Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          cubit
                                              .ratingDetailModel!
                                              .questions![cubit.index]
                                              .answers![index2]
                                              .label!,
                                        ),
                                        Checkbox(
                                          value: cubit.checkValues[index2]
                                                  ?[cubit.index] ??
                                              cubit.checkButtonValue,
                                          onChanged: (val) {
                                            cubit.changeCheckValues(
                                              questionIndex: cubit.index,
                                              answerIndex: index2,
                                              value: val!,
                                            );
                                            cubit.addCheckValueToListIfTrue(
                                              val,
                                              index2,
                                              ratingDetailModel
                                                  .questions![cubit.index]
                                                  .answers![index2]
                                                  .value!,
                                            );
                                            cubit.addChooseAnswerToMap(
                                              cubit.index,
                                              cubit.trueCheckValues,
                                              '2',
                                            );
                                            print(cubit.trueCheckValues);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: ReusableTextField(
                                      onChange: (val) {
                                        // cubit.noteController.text = val;
                                        cubit.addItemInControllersList(
                                          index: cubit.index,
                                          value: val,
                                        );
                                        print(cubit.controllersValues);
                                      },
                                      inRating: true,
                                      controller: cubit.noteController,
                                      textLabel: '',
                                      validate: (val) {},
                                      type: TextInputType.text,
                                    ),
                                    // TextFormField(
                                    //   controller: cubit.noteController,
                                    //   onChanged: (val) {
                                    //     cubit.noteController.text = val;
                                    //     cubit.addItemInControllersList(
                                    //         index: cubit.index, value: val);
                                    //     print(cubit.controllersValues);
                                    //   },
                                    // ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey[300],
                                      ),
                                      child: const Text(
                                        'ملاحظات',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: cubit.unitMembersModel == null
                                        ? Container()
                                        : Container(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: cubit.selectedMembers[
                                                      cubit.index] ??
                                                  cubit.selectedItem,
                                              onChanged: (value) {
                                                cubit.changeUnitInMenuMembers(
                                                  cubit.index,
                                                  value!,
                                                );
                                              },
                                              items: List.generate(
                                                cubit.unitMembersModel!.data!
                                                    .length,
                                                (index2) =>
                                                    DropdownMenuItem<String>(
                                                  onTap: () {
                                                    cubit.addOperationIdInList(
                                                      cubit.index,
                                                      cubit.unitMembersModel!
                                                          .data![index2].id!,
                                                    );
                                                    print(
                                                        'operations id  is ${cubit.operationsId[index2]}');
                                                  },
                                                  value:
                                                      '${cubit.unitMembersModel!.data![index2].firstname!}${cubit.unitMembersModel!.data![index2].lastname!}',
                                                  child: Text(
                                                      '${cubit.unitMembersModel!.data![index2].firstname!}${cubit.unitMembersModel!.data![index2].lastname}'),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey[300],
                                      ),
                                      child: const Text(
                                        'اسناد الي',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: GestureDetector(
                                      onTap: () async {
                                        await ImagePicker()
                                            .pickImage(
                                          source: ImageSource.camera,
                                        )
                                            .then((value) {
                                          cubit.imageFile = File(value!.path);
                                          cubit.fillImagesList(
                                            cubit.imageFile!.path,
                                            cubit.index,
                                          );
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: const [
                                                Expanded(
                                                  child: Icon(
                                                    Icons.camera_alt_outlined,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text('Camera'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () async {
                                                await ImagePicker()
                                                    .pickImage(
                                                  source: ImageSource.gallery,
                                                )
                                                    .then(
                                                  (value) {
                                                    cubit.imageFile =
                                                        File(value!.path);
                                                    cubit.fillImagesList(
                                                      cubit.imageFile!.path,
                                                      cubit.index,
                                                    );
                                                  },
                                                );
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: const [
                                                  Expanded(
                                                    child: Icon(
                                                      Icons.image_outlined,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text('Gallery'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey[300],
                                      ),
                                      child: const Text(
                                        'ارفاق ملف',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(cubit.imagesMap[cubit.index]
                                        ?.split('/')
                                        .last ??
                                    ''),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              color: Colors.white,
                              child: TextButton(
                                onPressed: () {
                                  if (cubit.index ==
                                      cubit.ratingDetailModel!.questions!
                                              .length -
                                          1) {
                                    showToast(
                                        msg:
                                            'تم الانتهاء من جميع الاسئلة. الرجاء الحفظ',
                                        toastStates: ToastStates.SUCCESS);
                                  }

                                  cubit.saveQuestionInList(
                                    SaveQuestions(
                                      choose: cubit.choosesMap[cubit.index],
                                      answerType: cubit.ratingDetailModel!
                                          .questions![cubit.index].answerType,
                                      id: cubit.ratingDetailModel!
                                          .questions![cubit.index].id,
                                      image: cubit.imagesMap[cubit.index] ?? '',
                                      notes: cubit
                                              .controllersValues[cubit.index] ??
                                          '',
                                      question: cubit.ratingDetailModel!
                                          .questions![cubit.index].question,
                                      operationId:
                                          cubit.operationsId[cubit.index],
                                    ),
                                  );
                                  print(cubit.savedQuestions);
                                  cubit.increaseIndex(cubit.index);
                                },
                                child: const Text(
                                  ' < التالي  ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (cubit.index > 0)
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomRight,
                                color: Colors.white,
                                child: TextButton(
                                  onPressed: () {
                                    cubit.decreaseIndex(cubit.index);
                                    cubit.deleteQuestionFromList(
                                      cubit.index,
                                      cubit.savedQuestions[cubit.index],
                                    );
                                    print(cubit.savedQuestions);
                                  },
                                  child: const Text(
                                    ' السابق >',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (state is SaveDataLoadingState)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              reusableButton(
                text: 'حفظ',
                radius: 0,
                function: () {
                  cubit.saveData();
                },
                width: double.infinity,
              ),
            ],
          ),
        );
      },
    );
  }
}
