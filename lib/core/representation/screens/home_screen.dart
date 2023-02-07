import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nz_vpn/core/constants/language_constants.dart';
import 'package:nz_vpn/core/representation/screens/setting_screen.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:nz_vpn/core/constants/color_constants.dart';
import 'package:nz_vpn/core/constants/dismension_constants.dart';
import 'package:nz_vpn/core/helpers/asset_helper.dart';
import 'package:nz_vpn/core/provider/server_provider.dart';
import 'package:nz_vpn/core/representation/screens/list_server_screen.dart';
import 'package:nz_vpn/core/representation/widgets/server_item_widget.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "/home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late OpenVPN engine;
  VpnStatus? status;
  VPNStage? stage;

  double downloadSpeed = 0;
  double uploadSpeed = 0;

  final internetSpeedTest = FlutterInternetSpeedTest();

  @override
  void initState() {
    super.initState();
    initVPNService();
  }

  void initVPNService() {
    engine = OpenVPN(
      onVpnStatusChanged: (data) {
        setState(() {
          status = data;
        });
      },
      onVpnStageChanged: (data, raw) {
        setState(() {
          stage = data;
        });
      },
    );

    engine.initialize(
      localizedDescription: "VPN",
      lastStage: (stage) {
        setState(() {
          this.stage = stage;
        });
      },
      lastStatus: (status) {
        setState(() {
          this.status = status;
        });
      },
    );
  }

  String getStatus(String? status) {
    if (status == VPNStage.disconnected.toString()) {
      return "START";
    }
    if (status == VPNStage.connected.toString()) {
      return "STOP";
    }
    return "WAITING";
  }

  String getMessage(String? status) {
    if (status == VPNStage.disconnected.toString()) {
      return translation(context).disconnected;
    }
    if (status == VPNStage.connected.toString()) {
      return translation(context).connected;
    }
    return translation(context).connecting;
  }

  Color getColor(String? status) {
    if (status == VPNStage.disconnected.toString()) {
      return ColorPalette.disConnectColor;
    }
    if (status == VPNStage.connected.toString()) {
      return ColorPalette.connectedColor;
    }
    return ColorPalette.waitConnectionColor;
  }

  String? getUploadSpeed(String? stage, VpnStatus? status) {
    if (stage == VPNStage.disconnected.toString()) {
      return "0	kB";
    }
    if (stage == VPNStage.connected.toString()) {
      double speedKB = double.parse(status?.packetsOut ?? '0') * 0.001;
      if (speedKB < 1000.0) {
        return '${speedKB.toStringAsFixed(0)} kB';
      }
      double speedMB = speedKB * 0.001024;
      return '${speedMB.toStringAsFixed(0).toString()} MB';
    }
    return "0	kB";
  }

  String? getDownloadSpeed(String? stage, VpnStatus? status) {
    if (stage == VPNStage.disconnected.toString()) {
      return '0 kB';
    }
    if (stage == VPNStage.connected.toString()) {
      double speedKB = double.parse(status?.packetsIn ?? '0') * 0.001;
      if (speedKB < 1000.0) {
        return '${speedKB.toStringAsFixed(0)} kB';
      }
      double speedMB = speedKB * 0.001024;
      return '${speedMB.toStringAsFixed(0).toString()} MB';
    }
    return "0	kB";
  }

  String getDuration(String? stage, VpnStatus? status) {
    if (stage == VPNStage.disconnected.toString()) {
      return '00:00:00';
    }
    if (stage == VPNStage.connected.toString()) {
      return status?.duration.toString() ?? '00:00:00';
    }
    return '00:00:00';
  }

  @override
  Widget build(BuildContext context) {
    final selectProvider = Provider.of<ServerNotifier>(context, listen: false);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          foregroundColor: ColorPalette.textColor,
          backgroundColor: ColorPalette.backgroundScaffoldColor,
          title: Text('VPN',
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600,
                fontSize: kAppbarFontSize,
              )),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  if (!mounted) return;
                  Navigator.of(context).pushNamed(SettingScreen.routeName);
                },
                icon: Icon(Icons.apps, size: kAppbarIconSize))
          ],
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                  vertical: screenSize.height * 0.05),
              decoration: BoxDecoration(
                  color: ColorPalette.backgroundScaffoldColor,
                  image: DecorationImage(
                      opacity: .1,
                      image: AssetImage(AssetHelper.imageBackground),
                      fit: BoxFit.cover)),
              child: SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: screenSize.height * 0.05,
                        child: Text(getMessage(stage?.toString()),
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500,
                              fontSize: kDefaultFontSize,
                            )),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      SizedBox(
                        height: screenSize.height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: kDefaultBorderRadius,
                                  color: ColorPalette.backgroundScaffoldColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorPalette.shadowColor
                                          .withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      child: Icon(Icons.file_upload_outlined),
                                    ),
                                    SizedBox(
                                      width: kDefaultMargin,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        "${getUploadSpeed(stage?.toString(), status)}",
                                        style: GoogleFonts.quicksand(
                                            color: ColorPalette.textColor,
                                            fontSize: kDefaultFontSize),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: kDefaultMargin * 4,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: kDefaultBorderRadius,
                                  color: ColorPalette.backgroundScaffoldColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorPalette.shadowColor
                                          .withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      child: Icon(Icons.file_download_outlined),
                                    ),
                                    SizedBox(
                                      width: kDefaultMargin,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        '${getDownloadSpeed(stage?.toString(), status)}',
                                        style: GoogleFonts.quicksand(
                                            color: ColorPalette.textColor,
                                            fontSize: kDefaultFontSize),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                          child: AvatarGlow(
                        glowColor: getColor(stage?.toString()),
                        endRadius: 100.0,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        shape: BoxShape.circle,
                        child: Material(
                          elevation: 2,
                          shape: CircleBorder(),
                          color: getColor(stage?.toString()),
                          child: SizedBox(
                            height: screenSize.height * 0.2,
                            width: screenSize.height * 0.2,
                            child: InkWell(
                              onTap: () async {
                                debugPrint(status?.toString());
                                if (stage?.toString() ==
                                    VPNStage.connected.toString()) {
                                  return engine.disconnect();
                                }
                                if (stage?.toString() ==
                                    VPNStage.disconnected.toString()) {
                                  engine.connect(
                                      await rootBundle.loadString(
                                          'assets/ovpn/${selectProvider.selectedItem.flagCode}.ovpn'),
                                      selectProvider.selectedItem.serverName,
                                      username: 'racevpn.com-vpn01',
                                      password: 'vpn01',
                                      certIsRequired: true);

                                  internetSpeedTest.startTesting(
                                    useFastApi: true,
                                    onCompleted: (TestResult download,
                                        TestResult upload) {
                                      setState(() {
                                        uploadSpeed =
                                            upload.transferRate.toDouble();
                                        downloadSpeed =
                                            download.transferRate.toDouble();
                                      });
                                    },
                                    onProgress:
                                        (double percent, TestResult data) {},
                                    onDownloadComplete: (TestResult data) {
                                      downloadSpeed =
                                          data.transferRate.toDouble();
                                    },
                                    onUploadComplete: (TestResult data) {
                                      uploadSpeed =
                                          data.transferRate.toDouble();
                                    },
                                  );

                                  return;
                                }
                                return engine.disconnect();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.power_settings_new,
                                    color: Colors.white,
                                    size: kStartIconSize,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    getStatus(stage?.toString()),
                                    style: GoogleFonts.quicksand(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      Center(
                          child: Text(
                        getDuration(stage?.toString(), status),
                        style: GoogleFonts.quicksand(
                          color: Color.fromRGBO(37, 112, 252, 1),
                          fontSize: kDefaultFontSize,
                        ),
                      )),
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      ServerItemWidget(
                        flagAsset: selectProvider.selectedItem.flagAsset,
                        label: selectProvider.selectedItem.serverName,
                        icon: Icons.arrow_forward,
                        onTap: () {
                          if (!mounted) return;
                          Navigator.of(context)
                              .pushNamed(ListServerScreen.routeName);
                        },
                      )
                    ]),
              )),
        ));
  }
}
