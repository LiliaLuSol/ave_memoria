
class Question {
  String text;
  List<String> options;
  int correctIndex;

  Question({required this.text, required this.options, required this.correctIndex});
}

class ImageQuestion {
  String imagePath;
  List<Question> questions;

  ImageQuestion({required this.imagePath, required this.questions});
}