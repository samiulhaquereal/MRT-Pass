import 'package:nfcmrt/src/app_config/imports/import.dart';

class WaitingCardView extends StatelessWidget {

  final String? title;
  final String? subtitle;
  final Widget? icon;

  const WaitingCardView({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width.w,
      height: 180.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF0F5D20),
              Color(0xFF8CA6DB),
            ]
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0.h,
            left: 140.w,
            child: Container(
              height: 340.h,
              width: 340.w,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.2),
                  borderRadius: BorderRadius.all(Radius.circular(200.r))
              ),
            ),
          ),
          Positioned(
            right: 20.w,
            top: 15.h,
            child: AssetImageView(fileName: AssetsPath.mrt_logo,height: 50.h,width: 50.w,),
          ),
          Positioned(
            right: 150.w,
            top: 40.h,
            child: icon ?? SizedBox.shrink(),
          ),
          Positioned(
            top: 70.h,
            right: 100.w,
            child: Text(title ?? '',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 35.h),
          Positioned(
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
            child: Text(
              subtitle ?? '',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}