enum AppRoutes {
   loginScreen("login_screen"),
  otpScreen("otp_screen"),
  bottomScreen("bottom_screen"),
  homeScreen("home_screen"),
  donarsScreen("search_screen"),
  profileScreen("profile_screen"),
  notificationScreen("notification_screen"),
  editProfileScreen("profile_edit_screen"),
  locationSearchScreen("location_search_screen"),
  createReqScreen("create_req_screen"),
  bloodDonateReqScreen("blood_donate_req_screen"),
  bloodDetailResScreen("blood_res_detail_scree"),
  requestDonarsResScreen("req_donars_res_screen"),
  rewardScreen("reward_screen"),
  donateOnBoardingScreen("donate_onboarding_screen");


  const AppRoutes(this.path);

  final String path;
}
