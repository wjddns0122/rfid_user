# RFID 물품 관리 시스템 - Claude Code 마이그레이션 가이드

## 프로젝트 개요
RC522 RFID 리더기로 물품 태그를 인식하고 Firebase Realtime DB에 저장하며,
Flutter 앱으로 실시간 조회하는 물품 관리 시스템 (캡스톤 디자인)

## 기술 스택
- **하드웨어**: RC522 RFID + ESP32
- **DB**: Firebase Realtime Database
- **앱**: Flutter
- **통신**: ESP32 WiFi → Firebase REST API → Flutter 실시간 스트림

## Firebase 정보
- **Realtime DB URL**: `https://rfid-user-db713-default-rtdb.firebaseio.com/`
- **보안 규칙**: 테스트 모드 (read/write 전체 허용) - 캡스톤 시연용
- **로그인**: 없음 (단일 기기 시연)

## Firebase DB 구조
```
logs/
  └─ {자동ID}/
       uid: "D6A32907"  ← 스캔된 카드 UID
       timestamp: 6297  ← millis() 값
```
※ items/ 컬렉션 없음 - Flutter에서 UID + timestamp 그대로 표시

## ESP32 하드웨어 연결
| RC522 핀 | ESP32 핀 |
|----------|----------|
| SDA      | D5       |
| SCK      | D18      |
| MOSI     | D23      |
| MISO     | D19      |
| RST      | D4       |
| GND      | GND      |
| VCC      | 3.3V     |

## ESP32 현재 코드 (작동 확인 완료)
```cpp
#include <SPI.h>
#include <MFRC522.h>
#include <WiFi.h>
#include <HTTPClient.h>

#define SS_PIN 5
#define RST_PIN 4

const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";
const char* firebaseURL = "https://rfid-user-db713-default-rtdb.firebaseio.com/logs.json";

MFRC522 mfrc522(SS_PIN, RST_PIN);

void setup() {
  Serial.begin(115200);
  SPI.begin();
  mfrc522.PCD_Init();

  WiFi.begin(ssid, password);
  Serial.print("WiFi 연결 중");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi 연결됨! IP: " + WiFi.localIP().toString());
  Serial.println("카드를 갖다 대세요...");
}

void loop() {
  if (!mfrc522.PICC_IsNewCardPresent()) return;
  if (!mfrc522.PICC_ReadCardSerial()) return;

  String uid = "";
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    if (mfrc522.uid.uidByte[i] < 0x10) uid += "0";
    uid += String(mfrc522.uid.uidByte[i], HEX);
  }
  uid.toUpperCase();
  Serial.println("UID: " + uid);

  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin(firebaseURL);
    http.addHeader("Content-Type", "application/json");

    String payload = "{\"uid\":\"" + uid + "\",\"timestamp\":" + millis() + "}";
    int httpCode = http.POST(payload);

    if (httpCode == 200) {
      Serial.println("Firebase 전송 성공!");
    } else {
      Serial.println("전송 실패: " + String(httpCode));
    }
    http.end();
  }

  mfrc522.PICC_HaltA();
  delay(1000);
}
```

## Flutter 앱 마이그레이션 작업 목록

### 1. Firebase 연동 설정
```bash
# FlutterFire CLI 설치
dart pub global activate flutterfire_cli

# 프로젝트 루트에서 실행
flutterfire configure
# → rfid-user-db713 프로젝트 선택
```

### 2. pubspec.yaml 패키지 추가
```yaml
dependencies:
  firebase_core: ^3.0.0
  firebase_database: ^11.0.0
```

### 3. main.dart 수정
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
```

### 4. 구현할 화면 1개

#### 화면 1 - 실시간 스캔 로그 (메인)
- Firebase logs/ 실시간 스트림 구독
- 카드 찍힐 때마다 목록에 자동 추가
- UID + timestamp 그대로 표시
- 예: "D6A32907 | 스캔됨"

### 5. Firebase 서비스 클래스 구조
```dart
// lib/services/firebase_service.dart

// logs 실시간 스트림
Stream<List<Map>> getLogsStream()

// items 전체 조회
Future<Map> getItems()

// 물품 등록
Future<void> registerItem(String uid, String name)
```

## 앱 폴더 구조 (목표)
```
lib/
├── main.dart
├── firebase_options.dart        ← flutterfire configure 자동 생성
├── screens/
│   └── home_screen.dart         ← 실시간 스캔 로그
└── services/
    └── firebase_service.dart    ← Firebase 연동 로직
```

## 시연 시나리오
1. 앱에서 물품 등록 (UID + 이름)
2. RC522에 카드 갖다 대기
3. ESP32 → Firebase logs/ 에 저장
4. Flutter 앱 실시간으로 "노트북 스캔됨!" 표시

## 현재 완료된 것
- [x] ESP32 + RC522 연결 및 UID 읽기
- [x] ESP32 WiFi 연결
- [x] Firebase Realtime DB 전송 (작동 확인)
- [x] Flutter 프로젝트 생성

## 남은 작업
- [ ] flutterfire configure 실행
- [ ] Firebase 패키지 추가
- [ ] FirebaseService 클래스 구현
- [ ] 실시간 스캔 로그 화면 구현 (UID + timestamp 표시)