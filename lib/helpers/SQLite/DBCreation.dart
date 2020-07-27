import 'package:sqflite/sqflite.dart';
import '../../helpers/helpers.dart';

class DBDefinition {
  static void onCreate(Database db, int version) async {
    logger.i("database is being created");
  }
}
