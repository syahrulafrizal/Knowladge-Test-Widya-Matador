import 'dart:io';

void main() {
  print("-----------Knowledge Test Widya Matador-----------");
  print("Masukan Angka : ");
  int? number = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < number; i++) {
    for (int j = 0; j < i + 1; j++) {
      stdout.write("*");
    }
    stdout.write("\n");
  }

  for (int i = number; i > 0; i--) {
    for (int j = i - 1; j > 0; j--) {
      stdout.write("*");
    }
    stdout.write("\n");
  }
}
