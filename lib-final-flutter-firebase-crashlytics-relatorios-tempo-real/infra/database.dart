import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/dao/transaction_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  Map<int, String> migrations = {
    1: ContactDao.createTable,
    2: TransactionDAO.createTable,
  };
  final int version = migrations.length;
  return openDatabase(
    path,
    onCreate: (db, version) async {
      for (int i = 1; i <= version; i++) {
        await db.execute(migrations[i]!);
      }
    },
    version: version,
    onUpgrade: (db, oldVersion, newVersion) async {
      for (int i = oldVersion + 1; i <= newVersion; i++) {
        await db.execute(migrations[i]!);
      }
    },
  );
}
