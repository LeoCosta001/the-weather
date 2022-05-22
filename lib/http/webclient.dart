import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:the_weather/http/interceptors/logging_interceptors.dart';

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: const Duration(seconds: 15),
);
