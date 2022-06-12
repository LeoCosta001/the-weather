import 'package:the_weather/models/positionstack_api/positionstack_api.dart';
import 'package:the_weather/models/positionstack_api/positionstack_location_normalize.dart';
import 'package:the_weather/shared/utils/string_normalize.dart';

class PositionstackApiUtils {
/*
###########################################################
### Regras para validação e filtro de resultados da API ###
###########################################################
-> Filtro de confiabilidade:
  - 1. Exibir resultados apenas com a key "confidence" tendo um valor >= 0.8.
  - 2. Caso nenhum resultado passe pelo primeiro ponto então também considerar valores >= 0.6.
  - OBS: A key "confidence" exibe o nivel de confiabilidade do resultado, e vai de "0" (nada confiável) até "1" (muito confiável).

-> Validações por tipo de localização:
  - 1. Caso a key "type" seja "continent" não deve ser exibidos resultados.
  - 2. Caso o valor seja "country":
    - Usar como label os campos "country - continent" (Exemplo: Brazil - South America).
  - 3. Caso o valor seja diferente de "country" e "continent" validar estes 3 casos:
    - 3.1. Se conter estas keys então exibir o label desta forma "neighbourhood - region - country" (Exemplo: Sé - São Paulo - Brazil).
    - 3.2. Se conter estas keys então exibir o label desta forma "locality - region - country" (Exemplo: Santo Andre - São Paulo - Brazil).
    - 3.3. Se conter estas keys então exibir o label desta forma "region - country - continent" (Exemplo: Amazonas - Brazil - South America).
    - OBS: Caso nenhum destes requisitos seja atendido então o resultado não deve ser exibido.
  - OBS: A key "type" exibe o tipo de localização (exemplo: continente, país, local, bairro, etc).

 -> Validações opcionais (por parâmetro) por nome da localização:
  - 1. Caso nos resultados a string pesquisada esteja presente em algum dos campos "region", "county", "neighbourhood" ou "country"
    Então apenas estes campos devem ser exibidos.
  - 2. Caso nenhum destes campos sejam iguais então ignorar o filtro e exibir os outros resultados encontrados
*/
  List<PositionstackApiData> normalizePositionstackApiData(List<PositionstackApiData> data, {
    String? useLocationNameFilter,
  }) {
    // Check "confidence"
    data.retainWhere((PositionstackApiData currentData) => currentData.confidence >= 0.8);
    if (data.isEmpty) {
      // Recheck "confidence"
      data.retainWhere((PositionstackApiData currentData) => currentData.confidence >= 0.6);
    }

    // Check type "continent"
    data.retainWhere((PositionstackApiData currentData) => currentData.type != 'continent');

    // Check other fields
    data.retainWhere((PositionstackApiData currentData) {
      if (currentData.region == null || currentData.country == null) return false;
      return true;
    });

    List<PositionstackApiData> dataWithoutLocationNameFilter = List.from(data);
    if (useLocationNameFilter != null) {
      data.retainWhere((PositionstackApiData currentData) {
        bool checkResult = false;
        final strNormalize = StringNormalize().toCompare;

        if (currentData.region != null) {
          if (strNormalize('${currentData.region}').contains(strNormalize(useLocationNameFilter))) checkResult = true;
        }

        if (currentData.county != null) {
          if (strNormalize('${currentData.county}').contains(strNormalize(useLocationNameFilter))) checkResult = true;
        }

        if (currentData.neighbourhood != null) {
          if (strNormalize('${currentData.neighbourhood}').contains(strNormalize(useLocationNameFilter))) {
            checkResult = true;
          }
        }

        if (currentData.country != null) {
          if (strNormalize('${currentData.country}').contains(strNormalize(useLocationNameFilter))) {
            checkResult = true;
          }
        }

        return checkResult;
      });

      if (data.isEmpty) data = dataWithoutLocationNameFilter;
    }

    return data;
  }

  PositionstackLocationNormalize locationNormalize(PositionstackApiData data) {
    final bool haveLocality = data.locality != null;
    final bool haveNeighbourhood = data.neighbourhood != null;

    late String title;
    late String subTitle;

    if (data.type == 'continent') {
      title = '${data.country}';
      subTitle = data.continent;
    } else if (haveLocality || haveNeighbourhood) {
      title = '${haveNeighbourhood ? data.neighbourhood : data.locality}';
      subTitle = '${data.region} - ${data.country}';
    } else {
      title = '${data.region}';
      subTitle = '${data.country} - ${data.continent}';
    }

    return PositionstackLocationNormalize(
        latitude: data.latitude,
        longitude: data.longitude,
        type: data.type,
        title: title,
        subTitle: subTitle,
    );
  }
}
