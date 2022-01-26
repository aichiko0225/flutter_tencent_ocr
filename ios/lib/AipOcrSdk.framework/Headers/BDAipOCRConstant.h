//
//  BDAipOCRConstant.h
//  AipOcrSdk
//
//  Created by Zhang,Jian(MBD) on 2021/12/20.
//  Copyright © 2021 baidu. All rights reserved.
//

#ifndef BDAipOCRConstant_h
#define BDAipOCRConstant_h

typedef enum : NSUInteger {
    BDRecognizeTypeGeneralBasic,  /**< 通用文字识别 */
    BDRecognizeTypeGeneralAccurateBasic,  /**< 通用文字识别(高精度版) */
    BDRecognizeTypeGeneral,  /**< 通用文字识别(含位置信息版) */
    BDRecognizeTypeGeneralAccurate,  /**< 通用文字识别(高精度含位置版 */
    BDRecognizeTypeGeneralEnchanced,  /**< 通用文字识别(含生僻字版  */
    BDRecognizeTypeWebImage,  /**< 网络图片文字识别  */
    BDRecognizeTypeIdcard,  /**< 身份证识别  */
    BDRecognizeTypeBankCard,  /**< 银行卡识别  */
    BDRecognizeTypeDrivingLicense,  /**< 驾驶证识别  */
    BDRecognizeTypeVehicleLicense,  /**< 行驶证识别  */
    BDRecognizeTypePlateLicense,  /**< 车牌识别  */
    BDRecognizeTypeBusinessLicense,  /**< 营业执照识别  */
    BDRecognizeTypeReceipt,  /**< 票据识别 */
    BDRecognizeTypeValInvoice,  /**< 增值税发票识别 */
    BDRecognizeTypeTaxiReceipt,  /**< 出租车票识别 */
    BDRecognizeTypeVinCode,  /**< VIN码识别 */
    BDRecognizeTypeTrainTicket,  /**< 火车票识别 */
    BDRecognizeTypeNumbers,  /**< 数字识别 */
    BDRecognizeTypeIOCR,  /**< 自定义模板识别 */
    BDRecognizeTypeQrcode,  /**< 二维码识别 */
    BDRecognizeTypeAirTicket,  /**< 行程单识别 */
    BDRecognizeTypeVehicleInvoice,  /**< 机动车销售发票识别 */
    BDRecognizeTypeVehicleCertificate,  /**< 车辆合格证识别 */
    BDRecognizeTypeDocAnalysis,  /**< 试卷分析与识别 */
    BDRecognizeTypeHandwriting,  /**< 手写识别 */
    BDRecognizeTypePassport,  /**< 护照识别 */
    BDRecognizeTypeHouseholdRegister,  /**< 户口本识别 */
    BDRecognizeTypeInvoice,  /**< 通用机打发票识别 */
    BDRecognizeTypeWeightNote,  /**< 磅单识别 */
    BDRecognizeTypeMedicalDetail,  /**< 医疗费用明细识别 */
    BDRecognizeTypeOnlineTaxiItinerary,  /**< 网约车行程单识别 */
    
    
} BDRecognizeType;

#endif /* BDAipOCRConstant_h */

