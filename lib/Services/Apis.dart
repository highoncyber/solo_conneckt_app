import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Views/CreatePost/index.dart';

class ApiUrl {
  static String login = "/User/Login.php";
  static String register = "/User/RegisterUser.php";
  static String registerForex = "/ForexProfile/RegisterForexUser.php";
  static String editUser = "/User/editUser.php";
  static String ProfileeditUser = "/ForexProfile/editProfileUser.php";
   static String checkEmail(email) =>
      "/User/CheckEmail.php?email=$email&auth_key=$auth_key";
  static String getUser(user_id, loginUser) =>
      "/User/GetUserProfile.php?user_id=$user_id&auth_key=$auth_key&logged_in_user_id=$loginUser";
  static String getPost = "/Post/GetPost.php?auth_key=$auth_key&byid=false";
  static String getPortfolio(user_id,type) => "/ForexProfile/GetPortfolio.php?auth_key=$auth_key&user_id=$user_id&type=$type";
  static String getPostById(userid, byid) =>
      "/Post/GetPost.php?auth_key=$auth_key&byid=$byid&user_id=$userid";
      static String getPostByInterest(interest,userid) =>
      "/Post/GetPost.php?auth_key=$auth_key&interest=$interest&user_id=$userid";
      static String getInterest()=>
      "/interest/GetInterest.php?auth_key=$auth_key";
      static String getUserInterest(userId)=>
      "/interest/GetUserInterest.php?auth_key=$auth_key&id=$userId";
  static String getSavedPost(userid) =>
      "/Post/SavedPost/GetSavedPost.php?auth_key=$auth_key&user_id=$userid";
  static String createLikedPost(userid) =>
      "/Post/LikedPost/CreateLikedPost.php?auth_key=$auth_key&user_id=$userid";
      static String createLikedGroupChat(userid) =>
      "/Chat/LikedGroup/CreateLikedGroupChat.php?auth_key=$auth_key&user_id=$userid";
  static String BlockUser() => "/User/BlockUser.php";
  static String getChat(user_id) => "/Chat/getGroupChat.php?auth_key=$auth_key&user_id=$user_id";
  static String getDirectChat(userid) =>
      "/Chat/GetDirectMessagesChat.php?auth_key=$auth_key&user_id=$userid";
  static String createPost = "/Post/CreatePost.php";
  static String createPortfolio = "/ForexProfile/CreatePost.php";
  static String deleteSavedPost(user_id, post_id) =>
      "/Post/SavedPost/deletePost.php?auth_key=$auth_key&user_id=$user_id&post_id=$post_id";
  static String deleteGroupChat(user_id) =>
      "/Chat/deleteGroup.php?auth_key=$auth_key&user_id=$user_id";
  static String deletePost(user_id, post_id) =>
      "/Post/deletePost.php?auth_key=$auth_key&user_id=$user_id&post_id=$post_id";
  static String deleteLikedPost(user_id, post_id) =>
      "/Post/LikedPost/deleteLikedPost.php?auth_key=$auth_key&user_id=$user_id&post_id=$post_id";
       static String deleteLikedGroup(user_id, post_id) =>
      "/Chat/LikedGroup/deleteLikedGroup.php?auth_key=$auth_key&user_id=$user_id&post_id=$post_id";
  static String reportPost(post_id) =>
      "/Post/reportPost.php?auth_key=$auth_key&post_id=$post_id";
  static String createSavedPost = "/Post/SavedPost/CreateSavedPost.php";
  static String createChatGroup = "/Chat/CreateGroupChat.php";
  static String getUserProfile = "/User/GetUserProfile.php?auth_key=$auth_key";
  static String getMessages(groupid) =>
      "/Chat/getMessages.php?auth_key=$auth_key&groupid=$groupid";
  static String getDirectMessages(receiver_id, sender_id) =>
      "/Chat/GetDirectMessages.php?auth_key=$auth_key&sender_id=$sender_id&receiver_id=$receiver_id";
  static String SendMessages = "/Chat/SendMessage.php";
  static String SendDirectMessages = "/Chat/SendDirectMessage.php";
  static String deleteStory(user_id, story_id) =>
      "/Stories/deleteStory.php?auth_key=$auth_key&user_id=$user_id&story_id=$story_id";
  static String UnblockUser(
    user_id,
    profileId,
  ) =>
      "/User/UnblockUser.php?auth_key=$auth_key&user_id=$user_id&profileId=$profileId";
  static String getStory(userid) =>
      "/Stories/GetStory.php?auth_key=$auth_key&user_id=$userid";
  static String createStory = "/Stories/CreateStory.php";
  static String getStoryByID(userid, byid) =>
      "/Stories/GetStory.php?auth_key=$auth_key&byid=$byid&user_id=$userid";

      ///personal profile
      ///
       static String getPersnalProfile(user_id,isactive,serial,type) =>
      "/PersonalProfile/GetPersonalProfile.php?user_id=$user_id&auth_key=$auth_key&isactive=$isactive&serial=$serial&type=$type";
         static String getUserDetails(user_id,serial) =>
      "/PersonalProfile/GetUserDetails.php?user_id=$user_id&auth_key=$auth_key&serial=$serial";
       static String getForexUserDetails(user_id,profile_type) =>
      "/ForexProfile/GetUserDetails.php?user_id=$user_id&auth_key=$auth_key&profile_type=$profile_type";
       static String getExchangeUser(user_id) =>
      "/PersonalProfile/GetExchange.php?user_id=$user_id&auth_key=$auth_key";
       static String getConnectionUser(user_id) =>
      "/PersonalProfile/GetConnections.php?user_id=$user_id&auth_key=$auth_key";
      static String insertCard = "/PersonalProfile/InsertCard.php";
      static String insertConnection = "/ForexProfile/CreateConnection.php";
      static String insertExchange= "/ForexProfile/CreateExchange.php";
      static String moveToConnections = "/PersonalProfile/MoveToConnections.php";
      static String addToExchange = "/PersonalProfile/insertExchange.php";
      static String updateActiveStatus = "/PersonalProfile/UpdateActiveStatus.php";
      static String updateUserInterest = "/interest/addUserInterest.php";
      static String activateProduct = "/User/activateProduct.php";
      static String editActiveUser = "/User/editActiveProfile.php";
      static String updateCardOrder = "/PersonalProfile/UpdateCardOrder.php";
      static String getUserId(serial) => "/User/getUserId.php?serialNo=$serial&auth_key=$auth_key";
       static String deleteConnection(id) =>
      "/PersonalProfile/DeleteConnection.php?auth_key=$auth_key&id=$id";
       static String deleteExchange(id) =>
      "/PersonalProfile/DeleteExchange.php?auth_key=$auth_key&id=$id";
      static String deletePorfolio(id) =>
      "/ForexProfile/deletePortfolio.php?auth_key=$auth_key&id=$id";
}
