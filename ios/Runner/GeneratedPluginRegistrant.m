//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<app_usage/AppUsagePlugin.h>)
#import <app_usage/AppUsagePlugin.h>
#else
@import app_usage;
#endif

#if __has_include(<background_fetch/BackgroundFetchPlugin.h>)
#import <background_fetch/BackgroundFetchPlugin.h>
#else
@import background_fetch;
#endif

#if __has_include(<flutter_secure_storage/FlutterSecureStoragePlugin.h>)
#import <flutter_secure_storage/FlutterSecureStoragePlugin.h>
#else
@import flutter_secure_storage;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [AppUsagePlugin registerWithRegistrar:[registry registrarForPlugin:@"AppUsagePlugin"]];
  [BackgroundFetchPlugin registerWithRegistrar:[registry registrarForPlugin:@"BackgroundFetchPlugin"]];
  [FlutterSecureStoragePlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterSecureStoragePlugin"]];
}

@end
