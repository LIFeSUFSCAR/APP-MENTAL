# Sensor Med

A biblioteca Sensor_Med tem como intuito a coleta de dados de sensores e o envio automático de tais dados para um servidor a escolha do desenvolvedor.

|             |  Android   |    iOS    |  Linux  |  macOS  | Web | Windows |
|:-----------:|:----------:|:---------:|:-------:|:-------:|:---:|:-------:|
| **Suporte** |  SDK 26+*  |  iOS 13+  |    ❌    |    ❌    |  ❌  |    ❌    |

* SDK 26+ é o SDK mínimo para a utilização da biblioteca no Android, porém, com a descontinuação da Fit API da Google, a biblioteca não suportará mais o SDK 26 e 27 a partir de algum momento do ano de 2024. Para versões posteriores ao SDK 28+, a biblioteca continuará a funcionar normalmente utilizando como base o Health Connect.

O sensor_med possui suporte a coleta dos seguintes sensores:

|     Sensor     |                       Dependências                        |
|:--------------:|:---------------------------------------------------------:|
|  Acelerômetro  |                          Nativo                           |
|   Giroscópio   |                          Nativo                           |
|  Localização   |                          Nativo                           |
|      Sono      | HealthKit (iOS) / Health Connect ou Google Fit* (Android) |
| Estado da Tela |                          Nativo                           |

* O Google Fit foi descontinuado em 2022 e será desligado em 2024, portanto, a biblioteca não suportará mais o Google Fit a partir de algum momento do ano de 2024 e é recomendado o uso do Health Connect para Android. Além disso, o Google Fit pode apresentar problemas de concessão de permissões, portanto caso ocorra é nescessário a insistencia de tempos em tempos para que a permissão seja detectada corretamente.

## Instalação

Para instalar a biblioteca, basta adicionar a seguinte linha no arquivo `pubspec.yaml`:

```yaml
dependencies:
  sensor_med: ^VERSION
```

Substitua `^VERSION` pela versão mais recente da biblioteca.

## Permissões

Antes de utilizar a biblioteca, é necessário solicitar permissões para a utilização de certos sensores. Abaixo, estão listadas as permissões necessárias para a utilização de cada sensor e como solicitá-las.

### Android

#### Serviço de Foreground (Obrigatório)

Para a utilização de sensores, é necessário a solicitação da permissão de serviço de foreground. Para isso, adicione a seguinte linha no arquivo `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
```

#### Envio de dados (Obrigatório)

Para a utilização de sensores de envio de dados, é necessário a solicitação da permissão de internet. Para isso, adicione a seguinte linha no arquivo `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

#### Localização (Opcional)

Para a utilização de sensores de localização, é necessário a solicitação da permissão de localização. Para isso, adicione as seguintes linhas no arquivo `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

Também será nescessário solicitar as permissões para coleta de permissão em background e foreground, para isso adicione as seguintes linhas no arquivo `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_LOCATION"/>
```

#### Sensores de Sono (Opcional)

Para a utilização de sensores de saúde, é necessário a solicitação da permissão de sensores de saúde. Para isso, adicione as seguintes linhas no arquivo `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.health.READ_SLEEP"/>
<uses-permission android:name="android.permission.health.WRITE_SLEEP"/>
<uses-permission android:name="android.permission.ACTIVITY_RECOGNITION"/>
```

Logo após, precisaremos configurar algumas intents para que o aplicativo possa coletar os dados de sono, para isso adicione as seguintes linhas no arquivo `AndroidManifest.xml`:

```xml
<!-- Intention to show Permissions screen for Health Connect API -->
<intent-filter>
    <action android:name="androidx.health.ACTION_SHOW_PERMISSIONS_RATIONALE"/>
</intent-filter>
```

```xml
<!-- Permissions screen for Health Connect API -->
<activity-alias
        android:name="ViewPermissionUsageActivity"
        android:exported="true"
        android:targetActivity=".MainActivity"
        android:permission="android.permission.START_VIEW_PERMISSION_USAGE">
    <intent-filter>
        <action android:name="android.intent.action.VIEW_PERMISSION_USAGE"/>
        <category android:name="android.intent.category.HEALTH_PERMISSIONS"/>
    </intent-filter>
</activity-alias>
```

Também precisaremos adicionar um parâmetro queries para que o aplicativo possa coletar os dados de sono, para isso adicione as seguintes linhas no arquivo `AndroidManifest.xml`:

```xml
<queries>
    <package android:name="com.google.android.apps.healthdata"/>
    <intent>
        <action android:name="androidx.health.ACTION_SHOW_PERMISSIONS_RATIONALE"/>
    </intent>
</queries>
```

Por fim, caso deseje utilizar em versões com Android 14+, precisaremos editar a MainActivity, para isso altere a `FlutterActivity` para `FlutterFragmentActivity` no arquivo `MainActivity.kt`:

```kotlin
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity()
```

* Caso deseje utilizar o Google Fit API, será nescessário configurar uma credencial OAuth 2.0, para isso siga o tutorial [aqui](https://developers.google.com/fit/android/get-api-key).

### iOS

#### Serviço de Foreground (Obrigatório)

Para a utilização em foreground e background de sensores, é necessário adicionar as seguintes capabilities no Xcode:

- Background Modes
  - Background fetch
  - Background processing

Também será nescessário, adicionar a seguinte linha no arquivo `Info.plist`:

```xml
<key>BGTaskSchedulerPermittedIdentifiers</key>
<array>
    <string>dev.flutter.background.refresh</string>
</array>
```

Você pode customizar o nome do identificador, mas lembre-se de alterar o mesmo no arquivo `AppDelegate.swift`:

```swift
import UIKit
import Flutter
import flutter_background_service_ios // add this

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    /// Add this line
    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "your.custom.task.identifier"

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

#### Envio de dados (Obrigatório)

Para o envio de dados usando o iOS, não é necessário nenhuma permissão adicional.
Entretanto, caso deseje utilizar uma conexão HTTP, será nescessário adicionar a seguinte linha no arquivo `Info.plist`:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

#### Localização (Opcional)

Para a utilização de sensores de localização, é necessário a solicitação da permissão de localização. Para isso, adicione as seguintes linhas no arquivo `Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Descrição da permissão</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>Descrição da permissão</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Descrição da permissão</string>
```

Além disso, será nescessário adicionar a seguinte capability no Xcode:

- Background Modes
  - Location updates

#### Sensores de Sono (Opcional)

Para a utilização de sensores de saúde, é necessário a solicitação da permissão de sensores de saúde. Para isso, adicione as seguintes linhas no arquivo `Info.plist`:

```xml
<key>NSHealthShareUsageDescription</key>
<string>Descrição da permissão</string>
<key>NSHealthUpdateUsageDescription</key>
<string>Descrição da permissão</string>
```

Além disso, será nescessário adicionar a seguinte capability no Xcode:

- HealthKit

## Utilização

### Inicialização da coleta de dados

Para inicalizar a captura de dados com a biblioteca, basta importar a mesma no arquivo que deseja utilizá-la e utilizar do singleton `SensorMed` para acessar o método de inicialização. Abaixo, está um exemplo de como inicializar a coleta de dados:

```dart
import 'package:sensor_med/sensor_med.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SensorMed.instance.startSensorsService(
    url: 'URL',
  );
}
```

O método `startSensorsService` do singleton `SensorMed` é configurável e aceita os seguintes parâmetros:

- `url` (String - Obrigatório): URL do servidor para onde os dados serão enviados.
- `captureAccelerometer` (bool - Opcional, Padrão: true): Define se os dados do acelerômetro serão capturados.
- `captureGyroscope` (bool - Opcional, Padrão: true): Define se os dados do giroscópio serão capturados.
- `captureLocation` (bool - Opcional, Padrão: true): Define se os dados de localização serão capturados.
- `captureSleep` (bool - Opcional, Padrão: true): Define se os dados de sono serão capturados.
- `captureScreenState` (bool - Opcional, Padrão: true): Define se os dados de estado da tela serão capturados.
- `sendDataInterval` (Duration - Opcional, Padrão: 5 segundos): Intervalo de tempo entre os envios de dados para o servidor.
- `captureDataThrottle` (Duration - Opcional, Padrão: 200 ms): Intervalo de tempo entre as capturas de dados.
- `healthDataCollectionInterval` (Duration - Opcional, Padrão: 1 dia): Intervalo de tempo entre as coletas de dados de saúde.
- `showDebug` (DebugLevel - Opcional, Padrão: error em debug e none em release): Define o nível de debug que será mostrado.
  - `DebugLevel.none`: Não mostra nenhum debug.
  - `DebugLevel.error`: Mostra apenas os erros.
  - `DebugLevel.verbose`: Mostra todos os debugs.
- `fieldsParameters` (FieldsParameters - Opcional): Define os nomes dos campos que serão capturados.
  - `sentAtField` (Padrão: `sendAt`): O nome do campo que será utilizado para a data de envio dos dados;
  - `sensorsField` (Padrão: `sensors`): O nome do campo que será utilizado para os dados dos sensores;
  - `gyroscopeDataField` (Padrão: `gyroscopeDate`): O nome do campo que será utilizado para os dados do giroscópio;
  - `accelerometerDataField` (Padrão: `accelerometerData`): O nome do campo que será utilizado para os dados do acelerômetro;
  - `locationDataField` (Padrão: `locationData`): O nome do campo que será utilizado para os dados de localização;
  - `sleepDataField` (Padrão: `sleepData`): O nome do campo que será utilizado para os dados de sono;
  - `screenStateDataField` (Padrão: `screenStateData`): O nome do campo que será utilizado para os dados de estado da tela;
  - `collectedAtField` (Padrão: `collectedAt`): O nome do campo que será utilizado para a data de coleta dos dados;
  - `sensorDataField` (Padrão: `data`): O nome do campo que será utilizado para os dados dos sensores;

É importante lembrar que uma vez iniciado o serviço de coleta de dados, o mesmo continuará ativo mesmo em caso de falhas, onde se comportará para tentar enviar os dados novamente e manter o funcionamento do serviço.

Caso deseje utilizar a coleta de dados junto ao Firebase, é recomendavel a utilização do Firebase Realtime Database, onde os dados podem ser enviados diretamente para o banco de dados. Abaixo, está um exemplo de como enviar os dados para o Firebase Realtime Database:

```dart
import 'package:sensor_med/sensor_med.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SensorMed.instance.startSensorsService(
    url:
    '$_databaseUrl/sensorsData/__at_date__/$_userId.json?auth=$_apiKey',
    showDebug: DebugLevel.verbose,
  );
}
```

Nele podemos observar que a URL é composta por três partes:

- `$_databaseUrl/sensorsData`: URL base do banco de dados.
- `__at_date__`: Tag que possibilita a inserção de uma data no formato dd-MM-yyyy, que será substituida pela data atual.
- `$_userId.json?auth=$_apiKey`: Tag que possibilita a inserção do id do usuário e da chave de autenticação.

Para a utilização do Firebase Realtime Database, é nescessário a configuração de uma API Key de web e a configuração do banco de dados, para mais informações, acesse a documentação do Firebase [aqui](https://firebase.google.com/docs).

### Parar a coleta de dados

Para parar a coleta de dados, basta utilizar o método `stopSensorsService` do singleton `SensorMed`:

```dart
import 'package:sensor_med/sensor_med.dart';

Future<void> function() async {
  await SensorMed.instance.stopSensorsService();
}
```

### Verificar se a coleta de dados está ativa

Também é possivel conferir se a coleta de dados está ativa utilizando o método `isSensorsServiceRunning` do singleton `SensorMed`:

```dart
import 'package:sensor_med/sensor_med.dart';

Future<void> function() async {
  final isRunning = await SensorMed.instance.isSensorsServiceRunning();
}
```

## Limitações

A biblioteca Sensor_Med possui algumas limitações que devem ser consideradas antes de sua utilização.

### Serviço de Background

A coleta de dados em background possui algumas limitações:

#### iOS

- A coleta de dados em background no iOS é limitada, pois apenas pode ocorrer caso o app esteja apenas minimizado e não completamente fechado.

#### Android

- A coleta de dados em background no Android pode ser limitada por serviços de economia de bateria, como o Doze Mode e o App Standby. Estes serviços variam de acordo com o dispositivo, fabricante e a versão do Android. Para consultar sobre seu dispositivo, acesso o site do Don't Kill My App [aqui](https://dontkillmyapp.com/).

### Giroscópio

A coleta de dados do giroscópio não possui nenhuma limitação, entretanto, a precisão dos dados pode variar de acordo com o dispositivo, além de que o dispositivo deve possuir o sensor de giroscópio para que a coleta de dados seja possível.

### Acelerômetro

A coleta de dados do acelerômetro não possui nenhuma limitação, entretanto, a precisão dos dados pode variar de acordo com o dispositivo, além de que o dispositivo deve possuir o sensor de acelerômetro para que a coleta de dados seja possível.

### Localização

A coleta de dados de localização não possui nenhuma limitação, entretanto, a precisão dos dados pode variar de acordo com o dispositivo, além de que será nescessário a permissão do usuário para a coleta de dados.

### Sono

A coleta de dados de sono possui algumas limitações:

#### iOS:

- É nescessário que o usuário tenha o aplicativo Health instalado e que o aplicativo tenha permissão para coletar os dados de sono, portanto a instalação em simuladores pode não funcionar.

#### Android:

- É nescessário que o usuário tenha o aplicativo Health Connect instalado em dispositivos com Android 9+ e que o aplicativo tenha permissão para coletar os dados de sono.

### Estado da Tela

A coleta de dados da tela possui algumas limitações:

#### iOS

- Para receber o estado de unlock da tela, o dispositivo nescessitará de uma senha configurada. Caso o dispositivo seja desbloqueado pelo touch ID ou Face ID, o estado de unlock pode não ser capturado.
- A coleta de dados não funciona em simuladores.
