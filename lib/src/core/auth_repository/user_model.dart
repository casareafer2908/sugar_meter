class AuthUser {
  final String ui;
  final String name;

  AuthUser(this.ui, this.name);

  @override
  String toString() => ('ui: $ui name: $name');
}
