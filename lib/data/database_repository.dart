abstract class DatabaseRepository {
  // Aktive Items
  Future<int> getItemCount();
  Future<List<String>> getItems();
  Future<void> addItem(String item);
  Future<void> deleteItem(int index);
  Future<void> editItem(int index, String newItem);

  // Papierkorb (gelöschte Items)
  Future<List<String>> getDeletedItems();
  Future<void> restoreDeletedItem(int index);
  Future<void> deleteDeletedItem(int index);
  Future<void> clearDeleted();
}
