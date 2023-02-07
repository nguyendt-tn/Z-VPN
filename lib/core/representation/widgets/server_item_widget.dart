import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nz_vpn/core/constants/color_constants.dart';
import 'package:nz_vpn/core/constants/dismension_constants.dart';

class ServerItemWidget extends StatelessWidget {
  const ServerItemWidget({
    Key? key,
    required this.label,
    required this.icon,
    required this.flagAsset,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final String flagAsset;
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
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorPalette.shadowColor.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: kCircleAvatarRadius,
                        backgroundColor: Colors.white,
                        backgroundImage: ExactAssetImage(
                          flagAsset,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: kMediumMargin,
                    ),
                    Text(label,
                        style: GoogleFonts.quicksand(
                          color: ColorPalette.textColor,
                          fontSize: kDefaultFontSize,
                        )),
                  ],
                ),
                IconButton(
                  onPressed: onTap,
                  icon: Icon(icon),
                  iconSize: kDefaultIconSize,
                  color: ColorPalette.textColor,
                )
              ],
            ),
          )),
    );
  }
}
