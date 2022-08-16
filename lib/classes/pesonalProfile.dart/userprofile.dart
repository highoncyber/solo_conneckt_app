
class PerosnalProfile_item{
  final String icon;
  final String title;
  final String url;
  final String order_by_id;
  final String active;
  final String id;
  PerosnalProfile_item(this.title,this.icon,this.order_by_id,
  this.url,this.id,
  this.active
  );
}


class UserDetails{
  final String user_name;
  final String image;
  final String user_id;
  UserDetails(
  this.user_name,this.image,this.user_id
  );
}

class ExchangeUser{
  final String user_name;
  final String image;
  final String exchangeId;
  final String id;
  final String user_id;
  ExchangeUser(
  this.user_name,this.image,this.exchangeId,this.id,this.user_id
  );
}


class ProfileDetails{
  final String profile_name;
  final String profile_slogan;
  final String profession;
  final String worksAt;
  final String profile_image;
  ProfileDetails(
  this.profile_name,this.profile_slogan
  ,this.profession,this.worksAt,this.profile_image
  );
}