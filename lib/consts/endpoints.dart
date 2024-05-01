class EndPoints {
  const EndPoints._();
  static const String imagesBaseUrl =
      'https://grizzly-trusty-purely.ngrok-free.app';
  static const String baseUrl = "http://192.168.43.176:5500/api";
  static const String prodBaseUrl =
      'https://grizzly-trusty-purely.ngrok-free.app/api';


      
  static const String animes = "/animes/";
  static const String animesSearch = "/animes/search";
  static const String favoritesAnime = "/favorite/user";
  static const String favoriteOperation = "/favorite/";


  static const String addReview = "/reviews/add";
  
  static const String episodes = "/episodes/";
  static const String singleEpisode = "/episodes/episode/";
  static const String streamEpisode = "/episodes/spisode/stream/";

  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String refreshToken = "/auth/refresh";
  static const String userInfo = "/users/me";
}
