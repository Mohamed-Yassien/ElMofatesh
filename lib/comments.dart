// Expanded(
// child: ListView.builder(
// physics: const BouncingScrollPhysics(),
// itemBuilder: (context, index) => Card(
// elevation: 20,
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 15,
// vertical: 24,
// ),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// crossAxisAlignment: CrossAxisAlignment.end,
// children: [
// Text(
// ratingDetailModel.questions![index].question!,
// textAlign: TextAlign.end,
// style: const TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 16,
// ),
// ),
// const SizedBox(
// height: 15,
// ),
// if (ratingDetailModel.questions![index].answerType ==
// '0')
// TextFormField(
// decoration: const InputDecoration(
// hintText: 'ضع اجابتك هنا',
// ),
// onChanged: (val) {
// answerController.text = val;
// // cubit.fillQuestions(
// //   index: index,
// //   saveQuestions: SaveQuestions(
// //     answerType: cubit.ratingDetailModel!
// //         .questions![index].answerType,
// //     choose: val,
// //   ),
// // );
// },
// textAlign: TextAlign.end,
// ),
// if (ratingDetailModel.questions![index].answerType ==
// '1')
// Column(
// children: [
// Row(
// children: List.generate(
// ratingDetailModel
//     .questions![index].answers!.length,
// (index2) => Expanded(
// child: Row(
// children: [
// Radio<int?>(
// value: ratingDetailModel
//     .questions![index]
// .answers![index2]
// .value,
// groupValue: cubit.radioGroupValue,
// onChanged: (val) {
// cubit.changeRadioSelected(val!);
// // cubit.fillQuestions(
// //   index: index,
// //   saveQuestions: SaveQuestions(
// //     choose:
// //         cubit.radioGroupValue != 0
// //             ? cubit
// //                 .ratingDetailModel!
// //                 .questions![index]
// //                 .answers![index2]
// //                 .value!
// //                 .toString()
// //             : null,
// //   ),
// // );
// },
// ),
// Expanded(
// child: Text(
// ratingDetailModel
//     .questions![index]
// .answers![index2]
// .label!,
// ),
// ),
// ],
// ),
// ),
// ),
// ),
// ],
// ),
// if (ratingDetailModel.questions![index].answerType ==
// '2')
// Column(
// crossAxisAlignment: CrossAxisAlignment.end,
// children: List.generate(
// ratingDetailModel
//     .questions![index].answers!.length,
// (index2) => Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Text(
// cubit.ratingDetailModel!.questions![index]
// .answers![index2].label!,
// ),
// Checkbox(
// value: cubit.checkValues[index2] ??
// cubit.checkButtonValue,
// onChanged: (val) {
// cubit.changeCheckValues(
// index: index2,
// value: val!,
// );
// },
// ),
// ],
// ),
// ),
// ),
// const SizedBox(
// height: 15,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Expanded(
// flex: 4,
// child: TextFormField(
// onChanged: (val) {
// noteController.text = val;
// },
// ),
// ),
// const SizedBox(
// width: 4,
// ),
// Expanded(
// flex: 1,
// child: Container(
// height: 50,
// alignment: Alignment.center,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(5),
// color: Colors.grey[300],
// ),
// child: const Text(
// 'ملاحظات',
// textAlign: TextAlign.center,
// ),
// ),
// ),
// ],
// ),
// const SizedBox(
// height: 15,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Expanded(
// flex: 4,
// child: cubit.unitMembersModel == null
// ? Container()
//     : Container(
// child: DropdownButton<String>(
// isExpanded: true,
// value: cubit.selectedMembers[index] ??
// cubit.selectedItem,
// onChanged: (value) {
// print(index);
// cubit.changeUnitInMenuMembers(
// index,
// value!,
// );
// },
// items: List.generate(
// cubit
//     .unitMembersModel!.data!.length,
// (index2) =>
// DropdownMenuItem<String>(
// value:
// '${cubit.unitMembersModel!.data![index2].firstname!}${cubit.unitMembersModel!.data![index2].lastname!}',
// child: Text(
// '${cubit.unitMembersModel!.data![index2].firstname!}${cubit.unitMembersModel!.data![index2].lastname}'),
// ),
// ),
// ),
// ),
// ),
// const SizedBox(
// width: 7,
// ),
// Expanded(
// flex: 1,
// child: Container(
// height: 50,
// alignment: Alignment.center,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(5),
// color: Colors.grey[300],
// ),
// child: const Text(
// 'اسناد الي',
// textAlign: TextAlign.center,
// ),
// ),
// ),
// ],
// ),
// const SizedBox(
// height: 15,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Expanded(
// flex: 4,
// child: Container(
// padding: const EdgeInsets.all(5),
// alignment: Alignment.centerRight,
// height: 45,
// width: double.infinity,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(2),
// border: Border.all(
// color: Colors.grey.shade300,
// width: 1,
// ),
// ),
// child: GestureDetector(
// onTap: () async {
// print(index);
// await showDialog(
// context: context,
// builder: (context) {
// return Center(
// child: Container(
// width: double.infinity,
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment
//     .spaceAround,
// children: [
// reusableButton(
// text: 'gallery',
// function: () async {
// await ImagePicker()
//     .pickImage(
// source:
// ImageSource.gallery,
// )
//     .then(
// (value) {
// cubit.fillImagesList(
// value!.name,
// index);
// },
// );
// },
// width: 150,
// ),
// reusableButton(
// text: 'camera',
// function: () async {
// await ImagePicker()
//     .pickImage(
// source:
// ImageSource
//     .camera)
//     .then(
// (value) {
// cubit.fillImagesList(
// value!.name,
// index);
// },
// );
// },
// width: 150,
// ),
// ],
// ),
// ),
// );
// },
// );
// },
// child: Text(
// cubit.imagesMap[index] ?? 'ارفاق ملف',
// style: const TextStyle(
// color: Colors.grey,
// fontSize: 13,
// ),
// ),
// ),
// ),
// ),
// const SizedBox(
// width: 4,
// ),
// Expanded(
// flex: 1,
// child: Container(
// height: 50,
// alignment: Alignment.center,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(5),
// color: Colors.grey[300],
// ),
// child: const Text(
// 'ارفاق ملف',
// textAlign: TextAlign.center,
// ),
// ),
// ),
// ],
// ),
// ],
// ),
// ),
// ),
// itemCount: ratingDetailModel.questions!.length,
// ),
// ),






