
class Post_item{
  final String post_id;
  final String post_image;
  final String datetime;
  final String caption;
  final String User_image;
  final String isreport;
  final String user_name;
  final String user_id;
   int isSaved;
   int isLiked;
  Post_item(this.post_id,this.user_id,this.post_image,
  this.datetime,this.caption,this.User_image,this.isreport,this.user_name,this.isLiked,this.isSaved
  );
}
class Portfolio_item{
  final String portfolio_id;
  final String profile_type;
  final String user_id;
  final String file;
  Portfolio_item(this.portfolio_id,this.profile_type,this.user_id,
  this.file
  );
}