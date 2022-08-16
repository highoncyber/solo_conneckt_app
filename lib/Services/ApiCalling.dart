import 'package:soloconneckt/Services/ApiClient.dart';

import 'Apis.dart';

class ApiCall {
  HttpService _httpService = HttpService();
  LoginUser(user_email, user_passowrd, context) {
    _httpService.Login(user_email, user_passowrd, context, ApiUrl.login);
  }

  // RegisterUser(name,email,number,password,imageFile,interest,  context ) {
  //   _httpService.register(name,email,number,password,imageFile, interest, context, ApiUrl.register,false,"");
  // }
  RegisterUser(name, email, number, password, imageFile, interest, context,
      hasImage, imagename) {
    _httpService.register(name, email, number, password, imageFile, interest,
        context, ApiUrl.register, false, "", hasImage, imagename);
  }

    RegisterForex(name, slogan, profession, workAt, imageFile,context,profileType,user_id,isedit,imagename,hasImage
      ) {
    _httpService.registerForex(name,slogan, profession, workAt, imageFile, profileType,
        context, isedit?ApiUrl.ProfileeditUser:ApiUrl.registerForex, isedit, user_id, hasImage, imagename);
  }

  // EditUser(
  //   id,
  //   name,
  //   email,
  //   number,
  //   password,
  //   imageFile,
  //   interest,
  //   context,
  // ) {
  //   _httpService.register(name, email, number, password, imageFile, interest,
  //       context, ApiUrl.editUser, true, id);
  // }
  EditUser(id, name, email, number, password, imageFile, interest, context,
      hasImage, imagename) {
    _httpService.register(name, email, number, password, imageFile, interest,
        context, ApiUrl.editUser, true, id, hasImage, imagename);
  }

  CreatePost(userid, datetime, Caption, imageFile,interest, context) {
    _httpService.NewPost(
        userid, datetime, Caption, imageFile,interest, context, ApiUrl.createPost);
  }
  CreatePorfolio(userid, profile_type,imageFile, context) {
    _httpService.NewPortfolio(
        userid, profile_type, imageFile, context, ApiUrl.createPortfolio);
  }
   MoveToConnection(id,context) {
    _httpService.MoveToConnections(id,context, ApiUrl.moveToConnections);
  }

 

  CreateStory(userid, datetime, Caption, imageFile,isVedio, context) {
    _httpService.NewStory(
        userid, datetime, Caption, imageFile,isVedio, context, ApiUrl.createStory);
  }

  CreateTopic(userid, datetime, name, imageFile, context) {
    _httpService.NewTopic(
        userid, datetime, name, imageFile, context, ApiUrl.createChatGroup);
  }

  SavedPost(userid, postid, context) {
    _httpService.SavedPost(userid, postid, context, ApiUrl.createSavedPost);
  }

  DeletePost(user_id, post_id, context) {
    _httpService.deleteSavedPost(
        user_id,
        post_id,
        context,
        ApiUrl.deleteSavedPost(
          user_id,
          post_id,
        ));
  }

  DeleteGroupChat(user_id, context) {
    _httpService.deleteGroupChat(
        user_id, context, ApiUrl.deleteGroupChat(user_id));
  }

  LikedPost(userid, postid, context) {
    _httpService.LikedPost(
        userid, postid, context, ApiUrl.createLikedPost(userid));
  }
 LikedGroup(userid, groupid, context) {
   print("user id ${userid}");
    print("group id ${groupid}");
    _httpService.LikedPost(
        userid, groupid, context, ApiUrl.createLikedGroupChat(userid));
  }
  DeleteLikedPost(user_id, post_id, context) {
    _httpService.delete(
        context,
        ApiUrl.deleteLikedPost(
          user_id,
          post_id,
        ));
  }
   DeletePorfolio(portfolio_id, context,) {
    _httpService.deletePortfolio(
        context,
        ApiUrl.deletePorfolio(
          portfolio_id,
        ));
  }
   DeleteLikedGroup(user_id, post_id, context) {
    print("user id ${user_id}");
    print("group id ${post_id}");
    _httpService.delete(
        context,
        ApiUrl.deleteLikedGroup(
          user_id,
          post_id,
        ));
  }


  ReportPost(post_id, context) {
    _httpService.reportPost(context, ApiUrl.reportPost(post_id));
  }

  DeleteUserPost(user_id, post_id, context) {
    _httpService.deletePost(
        context,
        ApiUrl.deletePost(
          user_id,
          post_id,
        ));
  }

  DeleteStory(user_id, story_id, context) {
    _httpService.deletePost(
        context,
        ApiUrl.deleteStory(
          user_id,
          story_id,
        ));
  }

  UnblockUser(user_id, profileId, context) {
    _httpService.UnblockUser(
        context,
        ApiUrl.UnblockUser(
          user_id,
          profileId,
        ));
  }

  BlockUser(user_id, profileId, context) {
    _httpService.BlockUser(user_id, profileId, context, ApiUrl.BlockUser());
  }

   DeleteConnection(id,  context) {
    _httpService.delete( context, ApiUrl.deleteConnection(id));
  }
  DeleteExchange(id,  context) {
    _httpService.delete( context, ApiUrl.deleteExchange(id));
  }
}
