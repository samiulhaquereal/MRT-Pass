import 'package:nfcmrt/src/app_config/imports/import.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: _blocListener,
        builder: _blocBuilder,
      ),
    );
  }

  void _blocListener(BuildContext context, SplashState state) {
    if (state is SplashLoaded) {
      NavigationHelper.goToDashboard(context);
    }
  }

  Widget _blocBuilder(BuildContext context, SplashState state) {
    if (state is SplashLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is SplashError) {
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
                context.read<SplashBloc>().add(AppStarted());
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}