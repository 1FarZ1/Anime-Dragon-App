class EndPoints {
  const EndPoints._();

  static const String baseUrl = "http://192.168.43.176:5500/api";
  static const String prodBaseUrl =
      'https://grizzly-trusty-purely.ngrok-free.app/api';
  static const String animes = "/animes/";
  static const String episodes = "/episodes/";
  static const String singleEpisode = "/episodes/episode/";
  static const String streamEpisode = "/episodes/spisode/stream/";

  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String refreshToken = "/auth/refresh";
}
