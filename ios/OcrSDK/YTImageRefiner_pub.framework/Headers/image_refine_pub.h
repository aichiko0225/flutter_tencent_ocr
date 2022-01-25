//
//  image_refine_pub.h
//  recdetect
//
//  Created by fujikoli(李鑫) on 2017/9/15.
//  Copyright © 2017年 fujikoli(李鑫). All rights reserved.
//

#ifndef IMAGE_REFINE_H
#define IMAGE_REFINE_H

#include <string>
#include <YTImageRefiner_pub/custom_opencv.h>

namespace IMAGE_REFINE {

enum class FilterType {
  kBright = 1,
  kSharp,
  kGray,
  kBinary,
};

enum class DetectType {
  kOldVersion = 0,
  kUnSpecified = 1,
  kHoriScreen,
  kVertiScreen,
  kVin,    // VIN 4
  kPlate,  // 车牌 5
  kIdCard,//身份证 6
  kBankCard,//银行卡 7
  kJsdCard,//驾驶证 8
  kXszCard,//行驶证 9
};

enum class SideType {
  kUnSpecified,
  kFront,
  kBack,
};

namespace WarningFlag {
constexpr const int kUnSpecified = 0x0;
constexpr const int kCover = 0x1;
constexpr const int kReflect = 0x1 << 1;
constexpr const int kMiss = 0x1 << 2;
constexpr const int kCopy = 0x1 << 3;
constexpr const int kRemake = 0x1 << 4;
}  // namespace WarningFlag

struct DetectResult {
  DetectType card_type = DetectType::kUnSpecified;
  SideType side_type = SideType::kUnSpecified;
  int warning_flags = WarningFlag::kUnSpecified;
};

class YtImageRefiner {
 public:
  static int GlobalInit(const std::string& model_path);
  static int GlobalDeinit();

  int BlurDetect(const yt_tiny_cv::Mat& src, double& result);

  int RectangleDetect(const yt_tiny_cv::Mat& src,
                      std::vector<yt_tiny_cv::Point>& squares,
                      DetectType DetectType = DetectType::kUnSpecified,
                      int skip_warning_flags = 0,
                      DetectResult* detect_result = nullptr,
                      double threshold1 = 1.5,
                      double threshold2 = 2.0);

  int RectangleDetect(const yt_tiny_cv::Mat& src,
                      std::vector<yt_tiny_cv::Point>& squares,
                      yt_tiny_cv::Rect& roi_rect,
                      DetectType DetectType = DetectType::kOldVersion,
                      int skip_warning_flags = 0,
                      DetectResult* detect_result = nullptr,
                      double threshold1 = 1.5,
                      double threshold2 = 2.0);
    
  int CropImage(const yt_tiny_cv::Mat& src,
                std::vector<yt_tiny_cv::Point>& squares,
                yt_tiny_cv::Mat& dst);

    int ImageFilter(const yt_tiny_cv::Mat& src,
                  yt_tiny_cv::Mat& dst,
                  FilterType filter_type);

 private:
  static bool _global_init_;
};
}  // namespace IMAGE_REFINE

#endif /* IMAGE_REFINE_H */
