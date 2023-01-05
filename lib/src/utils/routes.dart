enum AppRoutes {
  loginScreen("login_screen"),
  otpScreen("otp_screen"),
  bottomScreen("bottom_screen"),
  homeScreen("home_screen"),
  searchScreen("search_screen"),
  profileScreen("profile_screen"),
  notificationScreen("notification_screen"),
  editProfileScreen("profile_edit_screen"),
  locationSearchScreen("location_search_screen");


  const AppRoutes(this.path);

  final String path;
}
