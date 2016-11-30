//
//  UIImage+ALWebP.h
//  Pods
//
//  Created by alex on 2016/10/28.
//
//

#import <UIKit/UIKit.h>

/**
 基于SDWebImage与libwebp的封装
 加载本地WebP图片,fileurl可以表示mainbundle、子bundle、sanbox以及本地其他任何位置的webp图片
 */
@interface UIImage (ALWebP)


/**
 从mainBundle相对路径读取Webp图片
 
 @param absolutePath 图片在mainBundle中的相对路径
 @note  如相对路径relativePath: ALFoundation.bundle/webp/bts_im_sad@2x.webp
 @note  图片可以是全名也可以不带倍数及后缀名,如没有后缀名及倍数则会根据当前设备屏幕显示倍数自动选择
 
 */
+ (UIImage*)imageWebPWithRelativePath:(NSString*)relativePath;

/**
 从本地绝对路径FileURL读取Webp图片
 
 @param fileURL 本地绝对路径对应的fileURL
 @note  如真机上绝对路径fileURL: file:///private/var/mobile/Containers/Bundle/Application/216E36BF-2FEC-4451-9C65-86518338E0E7/ALFoundation_Example.app/ALFoundation.bundle/webp/bts_im_sad@2x.webp
 
 */
+ (UIImage*)imageWebPWithAbsolutePath:(NSURL*)fileURL;

/**
 UIImage对象转换成NSData
 
 @param quality分辨率 0~100
 
 @return NSData数据
 */
- (NSData *)dataWebPWithQuality:(float)quality;

@end
