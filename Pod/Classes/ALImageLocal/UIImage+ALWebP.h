//
//  UIImage+ALWebP.h
//  Pods
//
//  Created by alex on 2016/10/28.
//
//

#import <UIKit/UIKit.h>

/**
 使用URL加载WebP图片
 url可以是mainBundle、子Bundle、Sandbox以及本地其他任意位置的webP图片
 */
@interface UIImage (ALWebP)


/**
 从mainBundle相对路径读取Webp图片
 
 @param absolutePath 图片在mainBundle中的相对路径
 @note  如相对路径relativePath: ALFoundation.bundle/webp/bts_im_sad@2x.webp
 
 */
+ (UIImage*)imageWebPWithRelativePath:(NSString*)relativePath;

/**
 从本地绝对路径FileURL读取Webp图片
 
 @param fileURL 本地绝对路径对应的fileURL
 @note  如真机上绝对路径fileURL: file:///private/var/mobile/Containers/Bundle/Application/216E36BF-2FEC-4451-9C65-86518338E0E7/ALFoundation_Example.app/ALFoundation.bundle/webp/bts_im_sad@2x.webp
 
 */
+ (UIImage*)imageWebPWithAbsolutePath:(NSURL*)fileURL;

@end
