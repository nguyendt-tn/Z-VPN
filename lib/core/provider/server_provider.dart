import 'package:flutter/material.dart';
import 'package:nz_vpn/core/models/server.dart';

class ServerNotifier extends ChangeNotifier {
  final List<ServerModel> _servers = ServerModel.serverList();
  List<ServerModel> get servers => _servers;

  ServerModel _selectedItem = ServerModel.serverList()[0];
  ServerModel get selectedItem => _selectedItem;

  void chooseSelected(ServerModel server) {
    final serverIndex = _servers.indexOf(server);
    for (var element in _servers) {
      element.isSelected = false;
    }
    _servers[serverIndex].chooseSelected();
    _selectedItem = _servers[serverIndex];
    notifyListeners();
  }
}
