extension StringX on String? {
  String orNotSet() {
    if (this == null || this!.isEmpty) {
      return "-";
    } else {
      return toString();
    }
  }
}
