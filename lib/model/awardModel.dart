
class AwardModel {
  String award;

  AwardModel({this.award});

  AwardModel.fromJson(Map<String, dynamic> json) {
    award = json['award'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['award'] = this.award;
    return data;
  }
}
