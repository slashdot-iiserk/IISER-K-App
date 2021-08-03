import 'package:iiserk_app/utils/constants.dart';

class EventObject<T> {
  int id;
  T? object;

  EventObject({this.id: EventConstants.NO_INTERNET_CONNECTION, this.object});
}
