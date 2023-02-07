import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nz_vpn/core/constants/color_constants.dart';
import 'package:nz_vpn/core/constants/dismension_constants.dart';

class ItemSettingWidget extends StatelessWidget {
  const ItemSettingWidget(
      {Key? key, required this.icon, required this.title, required this.ontap})
      : super(key: key);

  final IconData? icon;
  final String? title;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(kDefaultPadding),
        child: InkWell(
          onTap: ontap,
          child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        icon,
                        size: kDefaultIconSize,
                        color: ColorPalette.textColor.withOpacity(0.7),
                      ),
                      SizedBox(
                        width: kDefaultMargin,
                      ),
                      Text(title ?? '',
                          style: GoogleFonts.quicksand(
                              fontSize: kDefaultFontSize,
                              color: ColorPalette.textColor))
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.keyboard_arrow_right,
                          color: ColorPalette.textColor.withOpacity(0.7))
                    ],
                  ),
                ))
          ]),
        ));
  }
}
