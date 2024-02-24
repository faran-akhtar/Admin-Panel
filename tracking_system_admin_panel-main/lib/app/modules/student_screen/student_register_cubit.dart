import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'student_register_export.dart';
import '../../../../sdk/sdk.dart';

class StudentRegisterCubit extends Cubit<StudentRegisterState> {
  StudentRegisterCubit(this.context)
      : super(StudentRegisterState(
          suggestions: const [],
        )) {
    userApi = UserApi();
  }
  BuildContext context;
  List<Map<String, dynamic>>? listOfSuggestions = [];
  UserApi? userApi;

  void searchPlaces(String query) async {
    emit(state.copyWith(status: SuggestionListStatus.loading));
  //  listOfSuggestions = [];
    final response = await userApi!.getUserPlace(place: query);
    if (response != null) {
      listOfSuggestions = List.from(response['results']);
      emit(
        state.copyWith(
          suggestions: listOfSuggestions,
        ),
      );
      emit(state.copyWith(status: SuggestionListStatus.none));
    }
  }


}
