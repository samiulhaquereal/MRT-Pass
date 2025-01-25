import 'package:nfcmrt/src/app_config/imports/import.dart';
import 'package:nfcmrt/src/presentation/screens/balance/widget/card_waiting.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<BalanceBloc, BalanceState>(
          listener: _blocListener,
          builder: _blocBuilder,
        ),
      ),
    );
  }

  Widget _blocListener(BuildContext context, BalanceState state) {
    if (state is WaitingForScan) {
      context.read<BalanceBloc>().add(CardScan());
    }
    return const SizedBox();
  }


  Widget _blocBuilder(BuildContext context, BalanceState state) {
    if (state is BalanceLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is BalanceError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.message,
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                print('Retry logic');
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    } else if (state is WaitingForScan) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
        child: Column(
          children: [
            WaitingCardView(
              title: 'Tap Your Card',
              subtitle: 'Hold your card behind your phone to read the balance',
              icon: Icon(LineAwesomeIcons.credit_card,color: Colors.white,size: 25.sp),
            ),
          ],
        ),
      );
    }else if (state is BalanceLoaded) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
        child: Column(
          children: [
            _buildBalanceCard(context,state.transactions),
            Gap(18.h),
            _buildRecentTransaction(state.transactions),
          ],
        ),
      );
    }
    return const SizedBox();
  }

  Widget _buildRecentTransaction(List<TransactionEntity> transactions) {
    return Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Journeys',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Divider(color: Colors.grey[300]),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${transaction.fromStation} → ${transaction.toStation == 'Unknown Station (0)' ? 'N/A' : transaction.toStation}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Gap(5.h),
                                    Text(
                                      '${transaction.timestamp}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                transaction.toStation == 'Unknown Station (0)' || transaction.fromStation == 'Unknown Station (0)' ? '৳ ${transaction.balance}' : '৳ -${transactions[index +1].balance - transaction.balance}',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: transaction.toStation == 'Unknown Station (0)' || transaction.fromStation == 'Unknown Station (0)'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildBalanceCard(BuildContext context, List<TransactionEntity> transactions) {
    return  FlipCard(
      key: flipCardKey,
      onTapFlipping:true,
      controller: flipCardController,
      frontWidget: CreditCardFont(
        cardNumber: transactions.isNotEmpty ? transactions[0].cardId : '',
        cardHolderName: '',
        onPressed: ()=> context.read<BalanceBloc>().add(PageLoaded()),
      ),
      backWidget: CreditCardBack(
        balance: transactions.isNotEmpty ? transactions[0].balance.toString() : '',
      ),
      rotateSide: RotateSide.right,
    );
  }
}