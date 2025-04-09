abstract interface class NoSqlLocalDatabase<T> {
  /// Inserts a document into the database.
  /// The collection is determined by the implementation.
  /// Returns a [T] the document which is inserted.
  /// Throws an error if the document already exists.
  Future<T> insert(T document);

  /// Retrieves a document by its ID.
  /// The collection is determined by the implementation.
  /// Returns the document or null if not found.
  Future<T?> getById(String id);

  /// Updates a document by its ID.
  /// The collection is determined by the implementation.
  /// Returns a [T] document which is updated.
  /// Throws an error if the document is not found.
  Future<T> update(String id, T updatedDocument);

  /// Deletes a document by its ID.
  /// The collection is determined by the implementation.
  /// Returns a boolean indicating success or failure.
  Future<bool> delete(String id);

  /// Retrieves all documents.
  /// The collection is determined by the implementation.
  /// Returns a list of documents.
  /// If no documents are found, an empty list is returned.
  Future<List<T>> getAll();

  /// Clears all documents.
  /// The collection is determined by the implementation.
  /// Returns a boolean indicating success or failure.
  Future<bool> clearCollection();
}
