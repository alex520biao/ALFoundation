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
#import "ALWebpCache.h"

#define kWebPLossless 146

@implementation UIImage (ALWebP)

+ (UIImage*)imageWebPWithFilePath:(NSString*)filePath{
    return [UIImage imageWebPWithFilePath:filePath cache:YES];
}

/**
 使用basePath及relativePath加载webp图片
 
 @param filePath    本地绝对路径(可以省略后缀名及倍数)
 @param cache       按照缓存-->文件系统的优先顺序加载图片
 
 @return webp格式图片
 */
+ (UIImage*)imageWebPWithFilePath:(NSString*)filePath cache:(BOOL)cache{
    if (!filePath) {
        return nil;
    }
    
    NSString *finalFilePath = [UIImage imageFinalPathWithFilePath:filePath cache:cache];
    UIImage *image = nil;
    //由缓存读取
    if (finalFilePath) {
        image = [[ALWebpCache sharedCache] imageForKey:finalFilePath];
    }
    
    //从文件系统读取
    if(!image){
        NSURL *fileURL = [NSURL fileURLWithPath:finalFilePath];
        if(!fileURL) return nil;
        image = [UIImage imageWebPWithAbsoluteFileURL:fileURL];
        if (cache) {
            [[ALWebpCache sharedCache] setImage:image forKey:finalFilePath];
        }
    }
    return image;
}

/**
 从本地绝对路径FileURL读取Webp图片
 
 @param fileURL 本地绝对路径对应的fileURL
 
 */
+ (UIImage*)imageWebPWithAbsoluteFileURL:(NSURL*)fileURL{
    UIImage *image = nil;
    //必须是本地fileURL
    if(fileURL && fileURL.fileURL){
        NSError *dataError = nil; //NSDataReadingMappedIfSafe防止内存消耗过大
        NSData *data = [NSData dataWithContentsOfURL:fileURL options:NSDataReadingMappedIfSafe error:&dataError];
        if (dataError != nil) {
            NSLog(@"webp image load failed: %@", dataError);
            return nil;
        }
        NSString *type = [NSData sd_contentTypeForImageData:data];

        //判断NSDta图片格式
        if ([type isEqualToString:@"image/webp"]) {
            image = [UIImage sd_imageWithWebPData:data];
        }
    }
    return image;
}


/**
 由filePath生成得到finalFilePath,默认优先使用缓存

 @param filePath

 @return
 */
+ (NSString*)imageFinalPathWithFilePath:(NSString*)filePath{
    return [UIImage imageFinalPathWithFilePath:filePath cache:YES];
}

/**
 由filePath生成得到finalFilePath

 @param filePath

 @return
 */
+ (NSString*)imageFinalPathWithFilePath:(NSString*)filePath cache:(BOOL)cache{
    if (!filePath) {
        return nil;
    }
    
    BOOL isFounded = NO;
    NSString *finalFilePath = nil;
    UIImage *image = nil;
    NSString *path = NULL;
    NSString *name = [filePath stringByDeletingPathExtension];
    NSString *ext = [filePath pathExtension];
    
    //获取relativePath中的scale倍数: @2x、@3x
    NSInteger scale = 0;
    if (name.length > 3) { // "@2x".length
        NSString *scaleStr = [name substringWithRange:NSMakeRange(name.length-3, 3)];
        if (scaleStr.length > 0) {
            if ([scaleStr hasPrefix:@"@"] && [scaleStr hasSuffix:@"x"]) {
                scale = [[scaleStr substringFromIndex:1] integerValue];
            }
        }
    }
    
    //无后缀名
    if(!ext || ext.length==0){
        //指定倍数
        if(scale>0){
            NSString *tmpFilePath = [filePath stringByAppendingString:@".webp" ];
            
            //判断缓存
            if(cache && [[ALWebpCache sharedCache] imageForKey:tmpFilePath]){
                isFounded = YES;
                finalFilePath = tmpFilePath;
            }
            
            if(!isFounded && [[NSFileManager defaultManager] fileExistsAtPath: tmpFilePath]){
                isFounded = YES;
                finalFilePath = tmpFilePath;
            }
        }
        //未指定倍数,则优先使用屏幕匹配倍数,其次按照3~1顺序匹配其他倍数
        else{
            NSInteger mainScreenScale = [UIScreen mainScreen].scale;
            NSString *tmpFilePath = [NSString stringWithFormat:@"%@@%zdx.webp",filePath,mainScreenScale];
            
            //判断缓存
            if(cache && [[ALWebpCache sharedCache] imageForKey:tmpFilePath]){
                isFounded = YES;
                finalFilePath = tmpFilePath;
            }

            if (!isFounded && [[NSFileManager defaultManager] fileExistsAtPath: tmpFilePath]) {
                isFounded = YES;
                finalFilePath = tmpFilePath;
            }else{
                // 2. try @3..1x version
                for (int i = 3; i > 0; i--) {
                    if (i == mainScreenScale) { // main screen scale
                        continue;
                    }
                    NSString *tmpFilePath= [NSString stringWithFormat:@"%@@%zdx.webp", name, i];
                    //判断缓存
                    if(cache && [[ALWebpCache sharedCache] imageForKey:tmpFilePath]){
                        isFounded = YES;
                        finalFilePath = tmpFilePath;
                    }

                    if (!isFounded && [[NSFileManager defaultManager] fileExistsAtPath: tmpFilePath]) {
                        scale = i;
                        isFounded = YES;
                        finalFilePath = tmpFilePath;
                        break;
                    }
                }
            }
        }
    }
    //有后缀名
    else{
        //判断缓存
        if(cache && [[ALWebpCache sharedCache] imageForKey:filePath]){
            isFounded = YES;
            finalFilePath = filePath;
        }
        
        if(!isFounded && [[NSFileManager defaultManager] fileExistsAtPath: filePath]){
            isFounded = YES;
            finalFilePath = filePath;
        }
    }
    return finalFilePath;
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
