class RecognizeDataModel {
  int? status;
  int? faceID;

  RecognizeDataModel({this.status, this.faceID});

  RecognizeDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    faceID = json['FaceID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['FaceID'] = this.faceID;
    return data;
  }
}