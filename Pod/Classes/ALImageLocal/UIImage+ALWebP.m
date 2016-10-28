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

@implementation UIImage (ALWebP)

/**
 从mainBundle相对路径读取Webp图片
 
 @param absolutePath 本地绝对路径
 
 */
+ (UIImage*)imageWebPWithRelativePath:(NSString*)relativePath{
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
        image = [UIImage sd_imageWithWebPData:data];
    }
    return image;
}


@end
