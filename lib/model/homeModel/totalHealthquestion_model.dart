// @dart=2.9
class HealthScoreQuestionModel {
  int status;
  String msg;
  List<HealthScoreQuestionData> data;

  HealthScoreQuestionModel({this.status, this.msg, this.data});

  HealthScoreQuestionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<HealthScoreQuestionData>();
      json['data'].forEach((v) {
        data.add(new HealthScoreQuestionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HealthScoreQuestionData {
  String questionId;
  String question;
  String answerA;
  String answerB;
  String answerC;
  String answerD;

  HealthScoreQuestionData(
      {this.questionId,
        this.question,
        this.answerA,
        this.answerB,
        this.answerC,
        this.answerD});

  HealthScoreQuestionData.fromJson(Map<String, dynamic> json) {
    questionId = json['QuestionId'];
    question = json['Question'];
    answerA = json['AnswerA'];
    answerB = json['AnswerB'];
    answerC = json['AnswerC'];
    answerD = json['AnswerD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['QuestionId'] = this.questionId;
    data['Question'] = this.question;
    data['AnswerA'] = this.answerA;
    data['AnswerB'] = this.answerB;
    data['AnswerC'] = this.answerC;
    data['AnswerD'] = this.answerD;
    return data;
  }
}
