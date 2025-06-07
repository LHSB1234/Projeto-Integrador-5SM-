class ChecklistData {
  static final ChecklistData _instance = ChecklistData._internal();

  factory ChecklistData() => _instance;

  ChecklistData._internal();

  List<String> reportData = [];

  void updateFromChecklist(List<String> data) {
    reportData = data;
  }

  List<String> getReport() => reportData;
}
