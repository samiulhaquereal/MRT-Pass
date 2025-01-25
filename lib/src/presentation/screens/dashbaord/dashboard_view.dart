import 'package:nfcmrt/src/app_config/imports/import.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc()..add(DashboardPageLoaded()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('MRT Pass',style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Color(0xFF0F5D20),
        ),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is! DashboardLoaded) {
              return Center(child: CircularProgressIndicator());
            }
            return IndexedStack(
              index: state.currentIndex,
              children: DashboardBloc.navigationPages,
            );
          },
        ),
        bottomNavigationBar: const CustomNavigationBar(),
      ),
    );
  }
}
