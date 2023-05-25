abstract class NetworkInfo {
  Future<bool> get isConnected;

}
class NetworkInfoImpl implements NetworkInfo{
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => throw UnimplementedError();

}