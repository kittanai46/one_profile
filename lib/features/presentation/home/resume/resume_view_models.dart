import 'package:flutter/material.dart';

class ResumeViewModel extends ChangeNotifier {
  String _resumeTitle = 'My Resume';
  String _resumeContent = '';

  String get resumeTitle => _resumeTitle;
  String get resumeContent => _resumeContent;

  void setResumeTitle(String title) {
    _resumeTitle = title;
    notifyListeners();
  }

  void setResumeContent(String content) {
    _resumeContent = content;
    notifyListeners();
  }
}
