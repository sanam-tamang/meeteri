import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel(
      {required String id,
      required String username,
      required String email,
      required String userType,
      required String dateOfBirth,
      required String gender,
      @Default("") String? avatar
      }) = _UserModel;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
