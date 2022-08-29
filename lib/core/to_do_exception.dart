class TodoException {
  final String error;
  const TodoException(this.error);
  @override
  String toString() => '''
    Todo Error: $error
      ''';
}
