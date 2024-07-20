extension IsValidString on String {
  bool isNotValidEmail() {
    bool isNotValidEmail = !RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
    return isNotValidEmail;
  }

  bool isNotValidPassword() {
    bool isNotValidPassword = this.length < 6;
    return isNotValidPassword;
  }
}
