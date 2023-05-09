import 'dart:async';

Function debounce(
  Function func, {
  int milliseconds = 250,
}) {
  Timer? timer;
  return () {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), () => func());
  };
}
