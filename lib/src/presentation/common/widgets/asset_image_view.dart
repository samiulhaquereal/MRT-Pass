import 'package:nfcmrt/src/app_config/imports/import.dart';

class AssetImageView extends StatelessWidget {
  const AssetImageView({
    required this.fileName,
    super.key,
    this.height,
    this.width,
    this.color,
    this.scale,
    this.fit,
  });

  final String fileName;
  final double? height;
  final double? width;
  final Color? color;
  final double? scale;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return _getView();
  }

  Widget _getView() {
    final String mimType = fileName.split('.').last;
    final String path = 'assets/images/$fileName';

    if (mimType.isEmpty) {
      return Icon(
        Icons.image_not_supported_outlined,
        size: width,
        color: color,
      );
    }

    switch (mimType) {
      case 'svg':
        return SvgPicture.asset(
          path,
          height: height,
          width: width,
          colorFilter: color == null
              ? null
              : ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
          fit: fit ?? BoxFit.contain,
        );
      case 'png':
      case 'jpg':
      case 'jpeg':
        return Image.asset(
          path,
          height: height,
          width: width,
          color: color,
          scale: scale,
        );
      default:
        return Icon(
          Icons.image_not_supported_outlined,
          size: width,
          color: color,
        );
    }
  }
}