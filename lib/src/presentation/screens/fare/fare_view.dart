import 'package:nfcmrt/src/app_config/imports/import.dart';

class FareScreen extends StatelessWidget {
  const FareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FareBloc(fareInformation: serviceLocator())..add(FarePageLoaded()),
      child: Scaffold(
        appBar: AppBar(title: Text('Fare Calculator')),
        body: BlocBuilder<FareBloc, FareState>(
          builder: (context, state) {
            if (state is FareInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FareLoaded) {
              final stations = state.stations;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // From Station Dropdown
                    DropdownButtonFormField<StationEntities>(
                      value: state.selectedFrom,
                      items: stations.map((station) {
                        return DropdownMenuItem(
                          value: station,
                          child: Text(station.name),
                        );
                      }).toList(),
                      onChanged: (StationEntities? newFrom) {
                        if (newFrom != null) {
                          context.read<FareBloc>().add(StationSelectionChanged(
                            selectedFrom: newFrom,  // Change the 'From' station
                            selectedTo: state.selectedTo,  // Keep the 'To' station intact
                          ));
                        }
                      },
                      decoration: InputDecoration(labelText: "From Station"),
                    ),


                    SizedBox(height: 16),
                    // To Station Dropdown
                    DropdownButtonFormField<StationEntities>(
                      value: state.selectedTo,
                      items: stations.map((station) {
                        return DropdownMenuItem(
                          value: station,
                          child: Text(station.name),
                        );
                      }).toList(),
                      onChanged: (StationEntities? newTo) {
                        if (newTo != null) {
                          context.read<FareBloc>().add(StationSelectionChanged(
                            selectedFrom: state.selectedFrom,  // Keep the 'From' station intact
                            selectedTo: newTo,  // Change the 'To' station
                          ));
                        }
                      },
                      decoration: InputDecoration(labelText: "To Station"),
                    ),

                    SizedBox(height: 32),
                    // Fare Display
                    Text(
                      "Fare: ৳${state.fare}",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text("Error loading fare data."));
            }
          },
        )

      ),
    );
  }
}
