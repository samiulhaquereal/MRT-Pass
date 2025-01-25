import 'dart:ui';
import 'package:nfcmrt/src/app_config/imports/import.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is! DashboardLoaded) {
          return SizedBox.shrink(); // Show nothing while the state is not loaded
        }

        return Stack(
          children: [
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      width: 1.5,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    selectedItemColor: Colors.green, // Replace with your AppColors.primaryColor
                    unselectedItemColor: Colors.grey, // Replace with custom color logic
                    currentIndex: state.currentIndex,
                    onTap: (index) {
                      context.read<DashboardBloc>().add(DashboardNavigationItemSelected(index));
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(LineAwesomeIcons.credit_card, size: 20.sp),
                        label: "Balance",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.calculate, size: 20.sp),
                        label: "Fare",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: state.currentIndex * MediaQuery.of(context).size.width / 2,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 3.h,
                color: Colors.green, // Replace with your AppColors.primaryColor
              ),
            ),
          ],
        );
      },
    );
  }
}
