abstract interface class Storage {
  void setData({required String key, required String value});
  String getData(String key);
  void clearData();
}
