import 'package:nfcmrt/src/app_config/imports/import.dart';
import 'package:nfcmrt/src/core/constants/asset_paths.dart';
import 'package:nfcmrt/src/presentation/common/widgets/asset_image_view.dart';

class CreditCardFont extends StatelessWidget {

  final String? cardNumber;
  final String? cardHolderName;
  final String? expiryDate;

  CreditCardFont({
    this.cardNumber,
    this.cardHolderName,
    this.expiryDate,
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
            top: -50,
            left: 140,
            child: Container(
              height: 335,
              width: 335,
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
            child: cardNumber?.isEmpty ?? true ? Text('XXXX  XXXX  XXXX  XXXX',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ) : Text( cardNumber!,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 35,),
          Positioned(
            bottom: 30,
            left: 20,
            child: Text(
              cardHolderName?.isEmpty ?? true ? 'TAP FOR BALANCE' : cardHolderName!,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: Text(
              expiryDate?.isEmpty ?? true ? '**/**' : expiryDate!,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}