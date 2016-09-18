//
//  UIImage+ALLocal.h
//  Pods
//
//  Created by alex520biao on 15/11/13. Maintain by alex520biao
//
//

#import <UIKit/UIKit.h>

/*!
 *  @brief  应用本地图片加载(包括mainBundle、自定义bundle、沙盒等)
 */
@interface UIImage (ALLocal)

#pragma mark -- ALLocal 本地包中的图片
/*!
 *  @brief 加载图片: 使用相对路径加载图片
 *
 *  @param relativePath 相对路径    @"ALFoundation.bundle/activity/activity_loading"
 *
 *  @return
 */
+ (UIImage*)imageWithRelativePath:(NSString*)relativePath;

/*!
 *  @brief 加载图片: 指定bundle及bundle中的相对路径. bundleName为nil则默认为mianBundle
 *
 *  @param bundleName   包名   如, ALFoundation
 *  @param relativePath 图片在包中的相对路径  如, activity/activity_loading
 *
 *  @return
 */
+ (UIImage *)imageWithBundleName:(NSString*)bundleName relativePath:(NSString *)relativePath;

/*!
 *  @brief 图片相对路径
 *
 *  @param bundleName   包名     如, ALFoundation
 *  @param relativePath 图片在包中的相对路径  如, activity/activity_loading
 *
 *  @return
 */
+ (NSString*)imageRelativePathWithBundleName:(NSString*)bundleName relativePath:(NSString*)relativePath;

@end
