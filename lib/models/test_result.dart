class TestResultModel {
  String processName;
  String referenceRange;
  String value;

  TestResultModel(this.processName, this.referenceRange, this.value);

  factory TestResultModel.fromJson(Map<String, dynamic> json) {
    return TestResultModel(
      json['processName'],
      json['referenceRange'],
      json['value'],
    );
  }
}

// bu modeli, LabResults modeli ile sarmalayabiliriz. 
// LabResult: {String appointmentDate, String testResultDate, String testType, List<TestResult> testResults}