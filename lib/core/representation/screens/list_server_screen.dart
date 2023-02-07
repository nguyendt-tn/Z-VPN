import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nz_vpn/core/constants/color_constants.dart';
import 'package:nz_vpn/core/constants/dismension_constants.dart';
import 'package:nz_vpn/core/constants/language_constants.dart';
import 'package:nz_vpn/core/helpers/asset_helper.dart';
import 'package:nz_vpn/core/models/server.dart';
import 'package:nz_vpn/core/provider/server_provider.dart';
import 'package:nz_vpn/core/representation/screens/home_screen.dart';
import 'package:nz_vpn/core/representation/widgets/server_item_list_widget.dart';
import 'package:provider/provider.dart';

class ListServerScreen extends StatefulWidget {
  const ListServerScreen({Key? key}) : super(key: key);
  static const routeName = '/list_server_screen';
  @override
  State<ListServerScreen> createState() => _ListServerScreenState();
}

class _ListServerScreenState extends State<ListServerScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          foregroundColor: ColorPalette.textColor,
          backgroundColor: ColorPalette.backgroundScaffoldColor,
          title: Text(
            translation(context).server,
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w600,
              fontSize: kAppbarFontSize,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
              vertical: screenSize.height * 0.05),
          decoration: BoxDecoration(
              color: ColorPalette.backgroundScaffoldColor,
              image: DecorationImage(
                  opacity: .1,
                  image: AssetImage(AssetHelper.imageBackground),
                  fit: BoxFit.cover)),
          child: SafeArea(child: Consumer<ServerNotifier>(
              builder: (context, serverProvider, child) {
            return ListView.separated(
              padding: EdgeInsets.all(kDefaultPadding / 4),
              shrinkWrap: true,
              itemCount: serverProvider.servers.length,
              itemBuilder: (context, index) => ServerItemListWidget(
                  item: serverProvider.servers[index],
                  onTap: () {
                    serverProvider
                        .chooseSelected(serverProvider.servers[index]);
                    if (!mounted) return;
                    Navigator.of(context).pushNamed(HomeScreen.routeName,
                        arguments: serverProvider.servers[index]);
                  }),
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: kMediumMargin),
            );
          })),
        ));
  }
}
