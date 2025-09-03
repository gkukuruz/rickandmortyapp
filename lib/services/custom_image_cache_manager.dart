import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomImageCacheManager extends CacheManager {
  static const String key = 'custom_image_cache';
  static const Duration cacheDuration = Duration(days: 7);

  CustomImageCacheManager():super(Config(
    key,
    stalePeriod: cacheDuration
  ));
}