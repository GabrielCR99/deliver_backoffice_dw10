class RepositoryException implements Exception {
  final String message;

  const RepositoryException({this.message = 'Erro ao buscar dados'});
}
