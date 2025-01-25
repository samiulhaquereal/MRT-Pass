import 'package:nfcmrt/src/app_config/imports/import.dart';


class CreditCardFont extends StatelessWidget {

  final String? cardNumber;
  final String? cardHolderName;
  final VoidCallback? onPressed;

  const CreditCardFont({super.key,
    this.cardNumber,
    this.cardHolderName,
    this.onPressed,
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
                  borderRadius: BorderRadius.all(Radius.circular(300))
              ),
            ),
          ),
          Positioned(
            right: 20.w,
            top: 15.h,
            child: AssetImageView(fileName: AssetsPath.mrt_logo,height: 50.h,width: 50.w,),
          ),
          Positioned(
            top: 90,
            left: 50,
            right: 50,
            child: cardNumber?.isEmpty ?? true ? Text('XX XX XX XX XX XX XX',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ) : Text( cardNumber!,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 35.h),
          Positioned(
            bottom: 30,
            left: 20,
            child: Text(
              cardHolderName?.isEmpty ?? true ? 'Tap For Balance' : cardHolderName!,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          Positioned(
            bottom: 10.h,
            right: 20.w,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8CA6DB), // Set your custom background color here
                ),
                onPressed: onPressed,
                child: Text('Rescan',style: TextStyle(fontSize: 10.sp,color: Colors.white))
            ),
          ),
        ],
      ),
    );
  }
}