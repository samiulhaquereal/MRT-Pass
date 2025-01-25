import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashbaord_event.dart';
part 'dashbaord_state.dart';

class DashbaordBloc extends Bloc<DashbaordEvent, DashbaordState> {
  DashbaordBloc() : super(DashbaordInitial()) {
    on<DashbaordEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
