// @dart=2.9
class MedicalHistroryQuestionModel {
  int status;
  String msg;
  MedicalHistroryQuestionData data;

  MedicalHistroryQuestionModel({this.status, this.msg, this.data});

  MedicalHistroryQuestionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new MedicalHistroryQuestionData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class MedicalHistroryQuestionData {
  String questionFirst;
  String questionSecond;
  String questionThird;
  String questionFourth;
  String questionFifth;
  String questionSixth;
  String questionSeventh;
  String questionEight;
  String questionNinth;
  String questionTenth;

  MedicalHistroryQuestionData(
      {this.questionFirst,
        this.questionSecond,
        this.questionThird,
        this.questionFourth,
        this.questionFifth,
        this.questionSixth,
        this.questionSeventh,
        this.questionEight,
        this.questionNinth,
        this.questionTenth});

  MedicalHistroryQuestionData.fromJson(Map<String, dynamic> json) {
    questionFirst = json['QuestionFirst'];
    questionSecond = json['QuestionSecond'];
    questionThird = json['QuestionThird'];
    questionFourth = json['QuestionFourth'];
    questionFifth = json['QuestionFifth'];
    questionSixth = json['QuestionSixth'];
    questionSeventh = json['QuestionSeventh'];
    questionEight = json['QuestionEight'];
    questionNinth = json['QuestionNinth'];
    questionTenth = json['QuestionTenth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['QuestionFirst'] = this.questionFirst;
    data['QuestionSecond'] = this.questionSecond;
    data['QuestionThird'] = this.questionThird;
    data['QuestionFourth'] = this.questionFourth;
    data['QuestionFifth'] = this.questionFifth;
    data['QuestionSixth'] = this.questionSixth;
    data['QuestionSeventh'] = this.questionSeventh;
    data['QuestionEight'] = this.questionEight;
    data['QuestionNinth'] = this.questionNinth;
    data['QuestionTenth'] = this.questionTenth;
    return data;
  }
}
