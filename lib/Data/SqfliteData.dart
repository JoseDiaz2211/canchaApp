import 'package:canchaflutter/Models/AgendaCanchaModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqflitedata {
  static final Sqflitedata _instance = new Sqflitedata.internal();

  factory Sqflitedata() => _instance;

  static Database _db;

  Sqflitedata.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await createDatabase();

    return _db;
  }

  deleteDataBase() async {
    String databasesPath = await getDatabasesPath();
    join(databasesPath, 'CanchaDB.db');
    createDatabase();
  }

  createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'CanchaDB.db');
    var database =
        await openDatabase(dbPath, version: 1, onCreate: createTableLocal);
    return database;
  }

  createTableLocal(Database database, int version) {
    database.execute("create table canchatb("
        "id integer primary key autoincrement,"
        "cancha text,"
        "fecha text,"
        "usuarioNombre text,"
        "lluviaPromedio text"
        ")");
  }

  nuevaCanchaDb(AgendaCanchaModel agendaCanchaModel) async {
    try {
      var resultDb = await db;
      await resultDb.insert("canchatb", agendaCanchaModel.toJson());
    } catch (e) {
      deleteDataBase();
    }
  }

  Future<String> eliminarCanchaDb(int id) async {
    try {
      var resultDb = await db;
      var result =
          await resultDb.rawDelete("delete from canchatb where id = $id");

      return result.toString();
    } catch (e) {
      deleteDataBase();
      return "";
    }
  }

  Future<List<AgendaCanchaModel>> listaCanchaDb() async {
    try {
      var resultDb = await db;
      var data =
          await resultDb.rawQuery("select * from canchatb order by fecha desc");
      if (data.length > 0) {
        var listaCancha =
            data.map((e) => AgendaCanchaModel.fromJson(e)).toList();

        return listaCancha;
      } else {
        return new List<AgendaCanchaModel>();
      }
    } catch (e) {
      deleteDataBase();
      return new List<AgendaCanchaModel>();
    }
  }
}
