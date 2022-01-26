// ignore_for_file: constant_identifier_names

enum OcrType {
  /// 身份证正面
  IDCardOCR_FRONT,
  /// 身份证反面
  IDCardOCR_BACK,     
  /// 银行卡识别
  BankCardOCR,        
  /// 名片识别
  BusinessCardOCR,    
  /// 马来西亚身份证识别
  MLIdCardOCR,        
  /// 车牌识别
  LicensePlateOCR,    
  ///  vin码识别
  VinOCR,              
  /// 行驶证主页
  VehicleLicenseOCR_FRONT, 
  /// 行驶证副页
  VehicleLicenseOCR_BACK,  
  /// 驾驶证主页
  DriverLicenseOCR_FRONT,  
  /// 驾驶证副页
  DriverLicenseOCR_BACK
}

class OcrProcessConfig {
  OcrType ocrType;

  /// 是否横屏显示
  bool? isHorizontal;

  /// 是否显示dialog
  bool? isShowTips;

  /// 提醒的dialog信息文字内容
  String? remindDialogText;

  /// 是否显示相册按钮
  bool? isShowAlbumBtn;

  /// 检测页面tips文案
  String? tipsShowText;

  OcrProcessConfig(this.ocrType, {
    this.isHorizontal,
    this.isShowTips,
    this.remindDialogText,
    this.isShowAlbumBtn,
    this.tipsShowText,
  });

  dynamic toMap() {
    final Map<String, dynamic> json = <String, dynamic>{};

    void addIfPresent(String fieldName, dynamic value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }

    addIfPresent('ocrType', ocrType.index);
    addIfPresent('isHorizontal', isHorizontal);
    addIfPresent('isShowTips', isShowTips);
    addIfPresent('remindDialogText', remindDialogText);
    addIfPresent('isShowAlbumBtn', isShowAlbumBtn);
    addIfPresent('tipsShowText', tipsShowText);
    return json;
  }

}