import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('Should return the value when create a transaction',(){
    final transaction = Transaction(42.0, Contact("name", 13), "132-456-789");
    expect(transaction.value, 42.0);
  });

  test('Should display error with value less than zero',(){
    expect(() => Transaction(0, Contact("name", 13), "132-456-789"), throwsAssertionError);
  });
}