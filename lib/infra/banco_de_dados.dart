import 'package:bytebank/dao/contato_dao.dart';
import 'package:bytebank/dao/transferencia_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  Map<int, String> migracoes = {
    1: ContatoDao.criaTabela,
    2: TransferenciaDAO.criaTabela,
  };
  final int totalDeMigracoes = migracoes.length;
  return openDatabase(
    path,
    onCreate: (db, version) async {
      for (int i = 1; i <= totalDeMigracoes; i++) {
        await db.execute(migracoes[i]!);
      }
    },
    version: totalDeMigracoes,
    onUpgrade: (db, oldVersion, newVersion) async {
      for (int i = oldVersion + 1; i <= newVersion; i++) {
        await db.execute(migracoes[i]!);
      }
    },
  );
}
