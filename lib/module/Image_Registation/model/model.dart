class FaceDataModel {
  int? status;
  int? faceID;
  int? version;

  FaceDataModel({this.status, this.faceID, this.version});

  FaceDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    faceID = json['FaceID'];
    version = json['Version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['FaceID'] = this.faceID;
    data['Version'] = this.version;
    return data;
  }
}