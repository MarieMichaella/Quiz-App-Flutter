import 'package:sqflite/sqflite.dart';
import 'package:quizapp/database/database_service.dart';
import 'package:quizapp/model/syncModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/syncservices.dart';

class DeletedItemsDB {
  final String tableName = 'deleted_items';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" TEXT PRIMARY KEY,
      "item_type" TEXT NOT NULL,  
      "deleted_at" INTEGER NOT NULL
    );""");
  }

  Future<void> storeDeletedItem(String id, String itemType) async {
    final database = await DatabaseService().database;
    await createTable(database);
    await database.rawInsert(
      '''INSERT INTO $tableName (id, item_type, deleted_at) VALUES (?,?,?)''',
      [id, itemType, DateTime.now().millisecondsSinceEpoch],
    );
  }

  Future<List<Map<String, dynamic>>> fetchAllDeletedItems() async {
    final database = await DatabaseService().database;
    return await database.query(tableName);
  }

  Future<void> deleteDeletedItem(String id) async {
  final database = await DatabaseService().database;
  await database.delete(tableName, where: 'id = ?', whereArgs: [id]);
}


  
}


class DeleteItemsFromFirestore {
  final SyncService syncService = SyncService();
  final DeletedItemsDB deletedItemsDB = DeletedItemsDB();

  Future<void> deleteFromFirestore() async {
    List<Map<String, dynamic>> deletedItems = await deletedItemsDB.fetchAllDeletedItems();

    for (var item in deletedItems) {
      String itemId = item['id'];
      String itemType = item['item_type'];

      switch (itemType) {
        case 'quiz':
          await syncService.deleteQuizFromFirestore(itemId);
          break;
        case 'question':
          await syncService.deleteQuestion(itemId);
          break;
        case 'answer':
          await syncService.deleteAnswer(itemId);
          break;
        default:
          throw Exception('Invalid item type: $itemType');
      }

      await deletedItemsDB.deleteDeletedItem(itemId);
    }
  }

}