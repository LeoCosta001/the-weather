import 'dart:convert';

import 'package:http/http.dart';
import 'package:the_weather/auth/secrets.dart';
import 'package:the_weather/http/webclient.dart';
import 'package:the_weather/models/positionstack_api/positionstack_api.dart';

const String positionstackApiBaseUrl = 'http://api.positionstack.com/v1';

class PositionstackApiWebClientDataOption {
  final String query;
  final int limit;

  PositionstackApiWebClientDataOption({required this.query, this.limit = 10});
}

class PositionstackApiWebClient {
  Future<PositionstackApi> getPositionstackApiData(PositionstackApiWebClientDataOption options) async {
    final Response response = await client.get(
      Uri.parse(positionstackApiBaseUrl +
          '/forward?access_key=$positionstackApiKey${_getPositionstackApiDataQueryString(options)}'),
    );

    final Map<String, dynamic> responseBodyToJson = jsonDecode(response.body);
    return PositionstackApi.fromJson(responseBodyToJson);
  }

  String _getPositionstackApiDataQueryString(PositionstackApiWebClientDataOption options) {
    final String query = '&query=${options.query}';
    final String limit = '&limit=${options.limit}';

    return '$query$limit';
  }
}
