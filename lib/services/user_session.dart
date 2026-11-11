class UserSession {
  static final UserSession instance = UserSession._internal();

  factory UserSession() => instance;

  UserSession._internal();

  String? username;
  String? email;
  String? userId;
  String? token;
  List<dynamic> userLists = [];
  Map<String, dynamic>? selectedListDetails;

  void setUser({String? username, String? email, String? userId, String? token}) {
    if (username != null) this.username = username;
    if (email != null) this.email = email;
    if (userId != null) this.userId = userId;
    if (token != null) this.token = token;
  }

  void clear() {
    username = null;
    email = null;
    userId = null;
    token = null;
    userLists.clear();
    selectedListDetails = null;
  }
}
