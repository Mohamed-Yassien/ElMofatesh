import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofatesh/cubit/ratings_cubit/states.dart';
import 'package:mofatesh/models/rating_detail_model.dart';
import 'package:mofatesh/models/ratings_model.dart';
import 'package:mofatesh/models/save_data_in_rating_model.dart';
import 'package:mofatesh/models/unit_members_unit.dart';
import 'package:mofatesh/models/units_model.dart';
import 'package:mofatesh/network/endpoints.dart';
import 'package:mofatesh/network/local/cache_helper.dart';
import 'package:mofatesh/network/remote/dio_helper.dart';
import 'package:mofatesh/shared/constants.dart';
import 'package:mofatesh/shared/widgets/reusable_toast.dart';

import '../../models/company_model.dart';

class RatingsCubit extends Cubit<RatingsStates> {
  RatingsCubit() : super(RatingsInitialState());

  static RatingsCubit get(context) => BlocProvider.of(context);

  RatingsModel? ratingsModel;

  void getRatingsData() {
    emit(RatingsGetDataLoadingState());
    DioHelper.getData(
      url: RATINGS_END_POINTS,
      token: token,
    ).then((value) {
      ratingsModel = RatingsModel.fromJson(value.data);
      print(ratingsModel!.data!.first.questions!.first.question);
      emit(RatingsGetDataSuccessState());
    }).catchError(
      (error) {
        print(error.toString());
        emit(RatingsGetDataErrorState());
      },
    );
  }

  RatingDetailModel? ratingDetailModel;

  getRatingDetails(int index) async {
    emit(GetRatingDetailsLoadingState());
    DioHelper.getData(url: '$RATINGS_END_POINTS2$index').then(
      (value) {
        ratingDetailModel = RatingDetailModel.fromJson(value.data);
        print(ratingDetailModel!.title);
        getCompaniesData();
        emit(
          GetRatingDetailsSuccessState(ratingDetailModel!),
        );
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(GetRatingDetailsErrorState());
      },
    );
  }

  int index = 0;
  var answerController = TextEditingController();
  var noteController = TextEditingController();

  Map<int, String> controllersValues = {};

  addItemInControllersList({
    required int index,
    required String value,
  }) {
    controllersValues.addAll(
      {
        index: value,
      },
    );
  }

  increaseIndex(int indexNow) {
    if (indexNow < ratingDetailModel!.questions!.length - 1) {
      indexNow++;
      index = indexNow;
      answerController.clear();
      noteController.clear();
      emit(IncreaseIndexState());
    }
  }

  decreaseIndex(int indexNow) {
    if (indexNow > 0) {
      indexNow--;
      index = indexNow;
      emit(DecreaseIndexState());
    }
  }

  int radioGroupValue = 0;

  Map<int, dynamic> choosesMap = {};

  addChooseAnswerToMap(
    int index,
    dynamic value,
    String answerType,
  ) {
    if (answerType == '0') {
      choosesMap.addAll(
        {
          index: value,
        },
      );
      emit(AddChooseValueInMapState());
    }
    if (answerType == '1') {
      radioGroupValue = value;
      //emit(GetRatingsChangeRadioSelectedState());
      choosesMap.addAll({
        index: value,
      });
      emit(AddChooseValueInMapState());
    }
    if (answerType == '2') {
      choosesMap.addAll({
        index: value,
      });
      emit(AddChooseValueInMapState());
    }
  }

  bool checkButtonValue = false;

  // Map<int, bool> checkValues = {};

  Map<int, Map<int, bool>> checkValues = {};

  List<int> trueCheckValues = [];

  addCheckValueToListIfTrue(bool status, answerIndex, int value) {
    if (status) {
      if (!trueCheckValues.contains(value)) {
        trueCheckValues.add(
          ratingDetailModel!.questions![index].answers![answerIndex].value!,
        );
        trueCheckValues.insert(index, 1);
      }
      return;
    } else {
      trueCheckValues.remove(
        ratingDetailModel!.questions![index].answers![answerIndex].value!,
      );
    }
  }

  changeCheckValues({
    required int questionIndex,
    required int answerIndex,
    required bool value,
  }) {
    checkValues.addAll({
      // answerIndex : value,
      answerIndex: {
        questionIndex: value,
      },
    });
    emit(ChangeCheckBoxValueState());
  }

  bool checkButtonValueInBaseRating = false;
  Map<int, bool> checkValuesInBaseRating = {};

  changeCheckValuesInBaseRatings({
    required int index,
    required bool value,
  }) {
    checkValuesInBaseRating.addAll({
      index: value,
    });
    emit(ChangeCheckBoxValueInBaseRatingsState());
  }

  UnitsModel? unitsModel;

  getUnits() {
    emit(ShowUnitsLoadingState());
    DioHelper.getData(
      url: SHOW_UNITS,
    ).then((value) {
      unitsModel = UnitsModel.fromJson(value.data);
      print(unitsModel!.data![0].buildingNumber);
      emit(ShowUnitsSuccessState());
    }).catchError(
      (error) {
        print(error);
        emit(ShowUnitsErrorState());
      },
    );
  }

  String? selectedUnit;

  // int? selectedUnitId;

  changeUnitInMenu(String selected) {
    selectedUnit = selected;
    emit(ChangeUnitInMenuState());
  }

  UnitMembersModel? unitMembersModel;

  String? selectedItem;
  Map<int, String> selectedMembers = {};

  getUnitMembers(int id) {
    emit(
      GetUnitMembersByIdLoadingState(),
    );
    DioHelper.getData(url: '$SHOW_UNITS_BY_ID$id').then((value) {
      unitMembersModel = UnitMembersModel.fromJson(value.data);
      emit(GetUnitMembersByIdSuccessState());
      print(unitMembersModel!.data![0].id);
    }).catchError((error) {
      print(error.toString());
      emit(GetUnitMembersByIdErrorState());
    });
  }

  changeUnitInMenuMembers(int index, String value) {
    selectedMembers.addAll({
      index: value,
    });
    emit(ChangeUnitInMenuState());
  }

  int? selectedIndex;

  Map<int, String> imagesMap = {};

  File? imageFile;

  fillImagesList(String imagePath, int index) {
    imagesMap.addAll(
      {
        index: imagePath,
      },
    );
    emit(ChangeImageNameInEveryQuestion());
  }

  CompanyModel? companyModel;

  getCompaniesData() {
    emit(GetCompaniesLoadingState());
    DioHelper.getData(url: SHOW_COMPANIES).then(
      (value) {
        companyModel = CompanyModel.fromJson(value.data);
        print(companyModel!.data!.length);
        emit(GetCompaniesSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(GetCompaniesErrorState());
    });
  }

  String? selectedCompany;

  changeCompanyInMenu(String selected) {
    selectedCompany = selected;
    emit(ChangeCompanyInMenuState());
  }

  int? templateId;
  int? unitId;
  int? companyId;

  Map<int, int> operationsId = {};

  addOperationIdInList(int index, int operationId) {
    operationsId.addAll(
      {
        index: operationId,
      },
    );
    emit(AddOperationIdInListState());
  }

  saveData() {
    if (index != ratingDetailModel!.questions!.length - 1) {
      showToast(
          msg: 'الرجاء الاجابة علي جميع الاسئلة',
          toastStates: ToastStates.ERROR);
      return;
    }
    if (unitId == null) {
      showToast(msg: 'الرجاء اختيار الوحدة', toastStates: ToastStates.ERROR);
      return;
    }
    if (companyId == null) {
      showToast(
          msg: 'الرجاء اختيار اسم الشركة', toastStates: ToastStates.ERROR);
      return;
    }
    emit(SaveDataLoadingState());
    SaveDataInRatingQuestionsModel saveDataInRatingQuestionsModel =
        SaveDataInRatingQuestionsModel(
      id: templateId,
      unitId: unitId,
      userId: CacheHelper.getData(key: 'userId'),
      companyId: companyId,
      questions: savedQuestions,
    );
    DioHelper.postData(
      url: SAVE_DATA,
      data: saveDataInRatingQuestionsModel.toJson(),
      token: token,
    ).then((value) {
      print(value.data);
      emit(SaveDataSuccessState());
      clearAllData();
      showToast(
        msg: 'تم الحفظ بنجاح',
        toastStates: ToastStates.SUCCESS,
      );
    }).catchError((error) {
      print(error.toString());
      emit(SaveDataErrorState());
    });
  }

  List<SaveQuestions> savedQuestions = [];

  saveQuestionInList(SaveQuestions saveQuestions) {
    savedQuestions.add(saveQuestions);
    emit(SaveQuestionInListState());
  }

  clearAllData() {
    savedQuestions.clear();
    templateId = null;
    unitId = null;
    companyId = null;
    selectedCompany = null;
    operationsId.clear();
    selectedIndex = null;
    imagesMap.clear();
    imageFile = null;
    selectedItem = null;
    selectedMembers.clear();
    selectedUnit = null;
    checkValues.clear();
    trueCheckValues.clear();
    choosesMap.clear();
    index = 0;
    controllersValues.clear();
    emit(ClearAllDataState());
  }
}
