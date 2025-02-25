

List<QuestionModel> questionModelFromJson(List json) => List<QuestionModel>.from(json.map((x) => QuestionModel.fromJson(x)));


class QuestionModel {
  final String id;
  final String question;
  String answer;

  QuestionModel({
    required this.question,
    required this.id,
    required this.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    id: json["Question_ID"],
    question: json["Question"],
    answer: json["Answer"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "Question": question,
    "Question_ID": id,
    "Answer": answer,
  };
}
