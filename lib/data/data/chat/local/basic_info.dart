enum MsState { completed, running, stopped, error, ready }

enum Role {
  system('system'),
  user('user'),
  assistant('assistant');

  final String value;
  const Role(this.value);

  static Role? fromValue(String value) {
    return Role.values.firstWhere(
      (role) => role.value == value,
      orElse: () => Role.assistant,
    );
  }
}