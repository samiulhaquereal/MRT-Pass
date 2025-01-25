import 'package:nfcmrt/src/app_config/imports/import.dart';

class FareScreen extends StatelessWidget {
  const FareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FareBloc(fareInformation: serviceLocator())..add(FarePageLoaded()),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<FareBloc, FareState>(
            builder: (context, state) {
              if (state is FareInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is FareLoaded) {
                final stations = state.stations;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                  child: Column(
                    children: [
                      _buildFareCard(state),
                      Gap(20.h),
                      _buildStationFrom(state, stations, context),
                      Gap(10.h),
                      _buildStationTo(state, stations, context),
                      Gap(10.h),
                      // Fare Display
                    ],
                  ),
                );
              } else {
                return Center(child: Text("Error loading fare data."));
              }
            },
          )
        ),
      ),
    );
  }

  Widget _buildStationTo(FareLoaded state, List<StationEntities> stations, BuildContext context) {
    return DropdownButtonFormField<StationEntities>(
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
                    decoration: InputDecoration(
                      filled: true,
                      labelText: "To Station",
                      fillColor: Colors.blue[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          width: 1.w,
                          color: Colors.grey.shade300
                        ),
                      ),
                    ),
                  );
  }

  Widget _buildStationFrom(FareLoaded state, List<StationEntities> stations, BuildContext context) {
    return DropdownButtonFormField<StationEntities>(
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
                    decoration: InputDecoration(
                      filled: true,
                      labelText: "From Station",
                      fillColor: Colors.blue[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                            width: 1.w,
                            color: Colors.grey.shade300
                        ),
                      ),
                    )
                  );
  }

  Widget _buildFareCard(FareLoaded state) {
    return Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
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
                      children: [
                        Text(
                          'with MRT Pass / Rapid Pass',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        Gap(10.h),
                        Text(
                          '৳ ${state.fare}',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Gap(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Single Ticket ৳ ${state.fare}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Discount ৳ ${state.discountedFare}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Gap(10.h),
                        Text(
                          'Your balance (৳ ${state.fare}) is sufficient.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  );
  }
}
