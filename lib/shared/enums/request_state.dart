enum RequestState {
  initial('initial'),
  empty('empty'),
  loading('loading'),
  ok('ok'),
  error('error');

  final String cycle;

  const RequestState(this.cycle);
}
