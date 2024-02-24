// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
enum SuggestionListStatus {
  none,
  loading,
}

// ignore: must_be_immutable
class StudentRegisterState extends Equatable {
  List<Map<String, dynamic>>? suggestions = [];
  bool? loading;
  String? studentAddress;
  SuggestionListStatus? status;
  double? studentLatitude;
  double? studentLongitude;
  StudentRegisterState({
    this.suggestions,
    this.status = SuggestionListStatus.loading,
    this.studentAddress,
    this.loading,
   
  });

  @override
  List<Object?> get props => [suggestions, loading, status, studentAddress];

 

  StudentRegisterState copyWith({
    List<Map<String, dynamic>>? suggestions,
    bool? loading,
    String? studentAddress,
    SuggestionListStatus? status,
  }) {
    return StudentRegisterState(
      suggestions: suggestions ?? this.suggestions,
      loading: loading ?? this.loading,
      studentAddress: studentAddress ?? this.studentAddress,
      status: status ?? this.status,
    );
  }
}
