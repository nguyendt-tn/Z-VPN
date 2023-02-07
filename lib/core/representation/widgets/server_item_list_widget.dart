import 'package:circle_checkbox/redev_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nz_vpn/core/constants/color_constants.dart';
import 'package:nz_vpn/core/constants/dismension_constants.dart';
import 'package:nz_vpn/core/helpers/image_helper.dart';
import 'package:nz_vpn/core/models/server.dart';

class ServerItemListWidget extends StatelessWidget {
  const ServerItemListWidget(
      {Key? key, required this.item, required this.onTap})
      : super(key: key);

  final ServerModel item;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.backgroundScaffoldColor,
        borderRadius: kDefaultBorderRadius,
        boxShadow: [
          BoxShadow(
            color: ColorPalette.shadowColor.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: InkWell(
            onTap: onTap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                        width: kFlagIconSize,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: ColorPalette.shadowColor.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ImageHelper.loadFromAsset(item.flagAsset,
                            fit: BoxFit.fitWidth)),
                    SizedBox(
                      width: kMediumMargin,
                    ),
                    SizedBox(
                      child: Text(item.serverName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.quicksand(
                            color: ColorPalette.textColor,
                            fontSize: kDefaultFontSize,
                          )),
                    ),
                  ],
                ),
                CircleCheckbox(value: item.isSelected, onChanged: null)
              ],
            ),
          )),
    );
  }
}
