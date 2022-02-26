class LocalRepository {
  static final LocalRepository _singleton = LocalRepository._internal();
  factory LocalRepository() => _singleton;
  LocalRepository._internal();
}

LocalRepository localRepository = LocalRepository();
