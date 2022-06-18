enum RequestState {
  initial('initial'),
  empty('empty'),
  loading('loading'),
  ok('ok'),
  customError('customError'),
  error('error');

  final String cycle;

  const RequestState(this.cycle);
}
