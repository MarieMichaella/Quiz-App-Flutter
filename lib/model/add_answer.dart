class Answer {
  final int id;
  final String answerText;
  final bool isCorrect;
  final int questionId;

  Answer({
    required this.id,
    required this.answerText,
    required this.isCorrect,
    required this.questionId,
  });

  factory Answer.fromMap(Map<String, dynamic> map) => Answer(
        id: map['id'],
        answerText: map['answer_text'],
        isCorrect: map['is_correct'] == 1 ? true : false,
        questionId: map['question_id'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'answer_text': answerText,
      'is_correct': isCorrect ? 1 : 0,
      'question_id': questionId,
    };
  }
}