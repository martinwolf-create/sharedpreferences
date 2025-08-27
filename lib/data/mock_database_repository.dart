// am Ende der Klasse MockDatabaseRepository:
@override
Future<List<String>> getDeletedItems() async => const [];

@override
Future<void> restoreDeletedItem(int index) async {}

@override
Future<void> deleteDeletedItem(int index) async {}

@override
Future<void> clearDeleted() async {}
