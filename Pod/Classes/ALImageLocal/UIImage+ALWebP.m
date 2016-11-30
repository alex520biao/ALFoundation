//
//  UIImage+ALWebP.m
//  Pods
//
//  Created by alex on 2016/10/28.
//
//

#import "UIImage+ALWebP.h"
//开启SD_WEBP开关
#define SD_WEBP 1
#import <SDWebImage/UIImage+WebP.h>
#import "NSData+ImageContentType.h"
#import <WebP/decode.h>
#import <WebP/encode.h>

#define kWebPLossless 146

@implementation UIImage (ALWebP)

/**
 从mainBundle相对路径读取Webp图片
 
 @param absolutePath 本地绝对路径
 
 */
+ (UIImage*)imageWebPWithRelativePath:(NSString*)relativePath{
#warning 支持自动补全后缀名，relativePath不带后缀名应该根据设备情况自动补全后缀及倍数 https://github.com/shmidt/WebP-UIImage/blob/master/Classes/UIImage%2BWebP.m
    NSString * bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString * filePath = [bundlePath stringByAppendingPathComponent:relativePath];
    UIImage *image = nil;
    if(filePath){
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        if(!fileURL) return nil;
        image = [UIImage imageWebPWithAbsolutePath:fileURL];
    }
    return image;
}

/**
 从本地绝对路径FileURL读取Webp图片
 
 @param fileURL 本地绝对路径对应的fileURL
 
 */
+ (UIImage*)imageWebPWithAbsolutePath:(NSURL*)fileURL{
    UIImage *image = nil;
    //必须是本地fileURL
    if(fileURL && fileURL.fileURL){
        NSData *data = [NSData dataWithContentsOfURL:fileURL];
        NSString *type = [NSData sd_contentTypeForImageData:data];

        //判断NSDta图片格式
        if ([type isEqualToString:@"image/webp"]) {
            image = [UIImage sd_imageWithWebPData:data];
        }
    }
    return image;
}


/**
 UIImage对象转换成NSData

 @param quality分辨率
 @note  https://github.com/shmidt/WebP-UIImage/blob/master/Classes/UIImage%2BWebP.m
 @return NSData数据
 */
- (NSData *)dataWebPWithQuality:(float)quality{
    int rc = WebPGetEncoderVersion();
    NSLog(@"WebP encoder version: %d", rc);
    
    CGImageRef imageRef = self.CGImage;
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    if (CGColorSpaceGetModel(colorSpace) != kCGColorSpaceModelRGB) {
        NSLog(@"Sorry, we need RGB");
    }
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    CFDataRef imageData = CGDataProviderCopyData(dataProvider);
    const UInt8 *rawData = CFDataGetBytePtr(imageData);
    
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    uint8_t *output;
    NSUInteger stride = CGImageGetBytesPerRow(imageRef);
    size_t ret_size;
    
    if (quality == kWebPLossless) {
        ret_size = WebPEncodeLosslessRGB(rawData, width, height, stride, &output);
    }else ret_size = WebPEncodeRGBA(rawData, width, height, stride, quality, &output);
    
    if (ret_size == 0) {
        NSLog(@"Oops, no data");
    }
    CFRelease(imageData);
    CGColorSpaceRelease(colorSpace);
    NSData *data = [NSData dataWithBytes:(const void *)output length:ret_size];
    
    return data;
}


@end
