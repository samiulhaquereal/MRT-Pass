import 'package:nfcmrt/src/app_config/imports/import.dart';

class CreditCardBack extends StatelessWidget {

  final String? balance;

  const CreditCardBack({
    super.key,
    this.balance,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('IF FOUND, PLEASE RETURN THE CARD TO THE NEAREST METRO RAIL STATION',style: TextStyle(color: Colors.white,fontSize: 12)),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              color: Colors.black,
            ),
          ),
          Positioned(
            top: 120,
            left: 15,
            right: 50,
            child: Container(
              height: 50,
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 135,
            right: 70,
            child: Text(balance?.isEmpty ?? true ? 'Latest Balance: 0' : 'Latest Balance: ৳ ${balance!}'),
          ),
          Positioned(
            top: 185,
            left: 25,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('www.dmtcl.gov.bd',style: TextStyle(color: Colors.white,fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}