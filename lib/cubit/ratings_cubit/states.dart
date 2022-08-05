import 'package:mofatesh/models/rating_detail_model.dart';

abstract class RatingsStates {}

class RatingsInitialState extends RatingsStates {}

class RatingsGetDataLoadingState extends RatingsStates {}

class RatingsGetDataSuccessState extends RatingsStates {}

class RatingsGetDataErrorState extends RatingsStates {}

class RatingsChangeCheckValue extends RatingsStates {}

class GetRatingDetailsLoadingState extends RatingsStates {}

class GetRatingDetailsSuccessState extends RatingsStates {
  final RatingDetailModel ratingDetailModel;

  GetRatingDetailsSuccessState(this.ratingDetailModel);
}

class GetRatingsChangeRadioSelectedState extends RatingsStates {}

class GetRatingDetailsErrorState extends RatingsStates {}

class ShowUnitsLoadingState extends RatingsStates {}

class ShowUnitsSuccessState extends RatingsStates {}

class ShowUnitsErrorState extends RatingsStates {}

class ChangeUnitInMenuState extends RatingsStates {}

class ChangeCompanyInMenuState extends RatingsStates {}

class GetUnitMembersByIdLoadingState extends RatingsStates {}

class GetUnitMembersByIdSuccessState extends RatingsStates {}

class GetUnitMembersByIdErrorState extends RatingsStates {}

class ChangeImageNameInEveryQuestion extends RatingsStates {}

class ChangeCheckBoxValueState extends RatingsStates {}

class ChangeCheckBoxValueInBaseRatingsState extends RatingsStates {}

class SaveDataLoadingState extends RatingsStates {}

class SaveDataSuccessState extends RatingsStates {}

class SaveDataErrorState extends RatingsStates {}

class GetCompaniesLoadingState extends RatingsStates {}

class GetCompaniesSuccessState extends RatingsStates {}

class GetCompaniesErrorState extends RatingsStates {}

class FillQuestionInMapState extends RatingsStates {}

class IncreaseIndexState extends RatingsStates {}

class DecreaseIndexState extends RatingsStates {}

class SaveQuestionInListState extends RatingsStates {}

class AddItemInControllersList extends RatingsStates {}

class AddOperationIdInListState extends RatingsStates {}

class AddChooseValueInMapState extends RatingsStates {}

class ClearAllDataState extends RatingsStates{}
