class UnitsModel {
  List<Data>? data;


  UnitsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? unitNumber;
  String? unitType;
  String? clientId;
  String? clientName;
  String? buildingNumber;
  String? permissions;
  String? pilgrims;
  String? nationality;
  String? company;
  String? image;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitNumber = json['unit_number'];
    unitType = json['unit_type'];
    clientId = json['client_id'];
    clientName = json['client_name'];
    buildingNumber = json['building_number'];
    permissions = json['permissions'];
    pilgrims = json['pilgrims'];
    nationality = json['nationality'];
    company = json['company'];
    image = json['image'];
  }

}
