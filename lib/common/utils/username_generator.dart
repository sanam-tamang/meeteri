import 'dart:math';

String generateUsername({String prefix = "@meeur"}) {
  final random = Random();
  int randomNumber = random.nextInt(9000) + 1000;
  const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
  String randomString =
      List.generate(5, (index) => characters[random.nextInt(characters.length)])
          .join();

  String username = '$prefix$randomString$randomNumber';

  return username;
}
