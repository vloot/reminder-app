class AppInfo {
  final String version;
  final String build;

  const AppInfo({required this.version, required this.build});

  @override
  String toString() => '$version+$build';
}
