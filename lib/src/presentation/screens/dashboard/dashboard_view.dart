import 'package:nfcmrt/src/app_config/imports/import.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MRT Pass',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: _blocListener,
        builder: _blocBuilder,
      ),
    );
  }

  Widget _blocListener(BuildContext context, DashboardState state) {
    return const SizedBox();
  }


  Widget _blocBuilder(BuildContext context, DashboardState state) {
    if (state is DashboardLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is DashboardError) {
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
    } else if (state is DashboardLoaded) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [],
          ),
        ),
      );
    }

    return const SizedBox();
  }

}