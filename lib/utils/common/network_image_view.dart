
import 'package:atm/config/app_colors.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

CachedNetworkImage networkImageView(imageUrl,
    {double height = 100, double width = 100, double placeholderLoadingSize = 40, BoxFit boxFit = BoxFit.cover}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    width: width,
    height: height,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: imageProvider,
            fit: boxFit,
            colorFilter: ColorFilter.mode(AppColors.greyColor.withOpacity(0.1), BlendMode.darken)),
      ),
    ),
    placeholder: (context, url) => Center(
        child: LoadingView(
      size: placeholderLoadingSize,
    )),
    errorWidget: (context, url, error) => const Icon(Icons.error, size: 30, color: AppColors.redColor),
  );
}
