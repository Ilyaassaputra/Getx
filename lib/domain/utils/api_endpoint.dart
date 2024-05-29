class ApiEndPoints {
  static final String baseUrl = "http://127.0.0.1:8000/api/"; //lokal
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
  // static final String baseUrl = "https://hello-ivy.id/AGUNG-MOU/public/api/";
}

class _AuthEndPoints {
  final String loginApi = 'loginMobile';
  final String getDataPendaftar = 'datapendaftar';
}
