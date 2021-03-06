import 'package:flutter/widgets.dart';
import 'package:sqflite/sqlite_api.dart';

import 'db_manager.dart';

abstract class BaseDBProvider {
  bool isTableExists = false;
  tableSqlString();
  tableName();

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExists = await DBManager.isTableExist(name);
    if (!isTableExists) {
      Database db = await DBManager.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExists) {
      await prepare(tableName(), tableSqlString());
    }
    return await DBManager.getCurrentDatabase();
  }
}
