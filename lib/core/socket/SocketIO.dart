import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIO {
  IO.Socket? _socket;

  // Connect and initialize socket only once
  void connectToSocket() {
    if (_socket != null && _socket!.connected) {
      print('Socket already connected');
      return;
    }

    print('Connecting to socket...');
    _socket = IO.io('http://10.0.2.2:8000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket!.onConnect((_) {
      print('Socket connected');
      _socket!.emit('connection');
      _socket!.on('welcome', (data) => print(data));
    });

    _socket!.onDisconnect((_) {
      print('Socket disconnected');
    });

    _socket!.on('pong', (data) {
      print('pong received: $data');
    });

    _socket!.connect(); // Manually connect
  }

  void testConnectionHealth() {
    if (_socket != null && _socket!.connected) {
      _socket!.emit('ping');
    } else {
      print('Socket not connected, cannot emit ping');
    }
  }

  void disconnect() {
    if (_socket != null) {
      _socket!.off('connect');
      _socket!.off('disconnect');
      _socket!.off('pong');
      _socket!.off('welcome');

      _socket!.disconnect();
      _socket = null;
      print('Socket disconnected and cleaned up');
    }
  }
}
