import 'dart:ui' show hashValues;

class OcrApiKey {
  /// Secret id
  final String secretId;
  /// Secret key
  final String secretKey;

  ///构造AMapKeyConfig
  ///
  ///[secretId] Secret id
  ///
  ///[secretKey] Secret key
  const OcrApiKey({required this.secretId, required this.secretKey});

  dynamic toMap() {
    final Map<String, dynamic> json = <String, dynamic>{};

    void addIfPresent(String fieldName, dynamic value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }

    addIfPresent('secretId', secretId);
    addIfPresent('secretKey', secretKey);
    return json;
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final OcrApiKey typedOther = other;
    return secretId == typedOther.secretId && secretKey == typedOther.secretKey;
  }

  @override
  int get hashCode => hashValues(secretId, secretKey);

  @override
  String toString() {
    return 'OcrApiKey(secretId: $secretId, secretKey: $secretKey)';
  }

}