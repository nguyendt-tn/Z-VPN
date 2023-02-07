import 'package:nz_vpn/core/helpers/asset_helper.dart';

class ServerModel {
  String flagAsset;
  String serverName;
  bool isSelected;
  String flagCode;

  ServerModel(
      {required this.flagAsset,
      required this.serverName,
      required this.isSelected,
      required this.flagCode});

  void chooseSelected() {
    isSelected = !isSelected;
  }

  static List<ServerModel> serverList() {
    return <ServerModel>[
      ServerModel(
          flagAsset: AssetHelper.flagSingapore,
          serverName: 'Singapore',
          flagCode: 'sg',
          isSelected: false),
      ServerModel(
          flagAsset: AssetHelper.flagVietNam,
          serverName: 'Viet Nam',
          flagCode: 'vn',
          isSelected: false),
      ServerModel(
          flagAsset: AssetHelper.flagUsa,
          serverName: 'United States',
          flagCode: 'us',
          isSelected: false),
      ServerModel(
          flagAsset: AssetHelper.flagJapan,
          serverName: 'Japan',
          flagCode: 'ja',
          isSelected: false),
      ServerModel(
          flagAsset: AssetHelper.flagMalaysia,
          serverName: 'Malaysia',
          flagCode: 'ma',
          isSelected: false),
      ServerModel(
          flagAsset: AssetHelper.flagIndonesia,
          serverName: 'Indonesia',
          flagCode: 'indo',
          isSelected: false)
    ];
  }
}
