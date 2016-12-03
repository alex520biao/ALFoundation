//
//  UIImage+ALBundle.m
//  Pods
//
//  Created by alex520biao on 15/11/13. Maintain by alex520biao
//
//

#import "UIImage+ALBundle.h"
#import "UIImage+ALWebP.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UIImage (ALBundle)

#pragma mark -- hook_imageNamed
/**
 类的初始化先于对象
 */
+(void)load{
    //与系统[UIImage imageNamed:]方法交换实现,替换之后调用hook_imageNamed为原系统方法imageNamed,调用imageNamed相当于hook_imageNamed:
    method_exchangeImplementations(class_getClassMethod(self, @selector(imageNamed:)),
                                   class_getClassMethod(self, @selector(hook_imageNamed:)));
}

/**
 在[UIImage imageNamed:]方法末尾插入新代码
 @param imageName 图片在mainBundle中的相对路径relativePath

 @return
 */
+(UIImage*)hook_imageNamed: (NSString*)imageName{
    //优先使用[UIImage imageNamed:]读取png/jpg等系统支持格式
    //hook_imageNamed:与原imageNamed:方法实现进行了替换,此时myImageNamed:即为系统原imageNamed:方法
    UIImage *image = [UIImage hook_imageNamed:imageName];
        
    //无png、jpg图片,则检查其他更多图片格式: 如WebP格式
    if (!image && imageName && imageName.length>0) {
        NSString * bundlePath = [[NSBundle mainBundle] bundlePath];
        NSString * filePath = [bundlePath stringByAppendingPathComponent:imageName];
        image = [UIImage imageWebPWithFilePath:filePath];
    }
    return image;
}

#pragma mark -- 加载ALBundle本地包中的图片
/*!
 *  @brief 使用相对路径加载图片
 *
 *  @param relativePath app的mainBundle相对路径    @"ALFoundation.bundle/activity/activity_loading"
 *
 *  @return
 */
+(UIImage*)imageWithRelativePath:(NSString*)relativePath{    
    //优先使用[UIImage imageNamed:]读取png/jpg等系统支持格式
    //hook_imageNamed:与原imageNamed:方法实现进行了替换,此时myImageNamed:即为系统原imageNamed:方法
    UIImage *image = [UIImage hook_imageNamed:relativePath];
    
    //无png、jpg图片,则检查其他更多图片格式: 如WebP格式
    if (!image && relativePath && relativePath.length>0) {
        NSString * bundlePath = [[NSBundle mainBundle] bundlePath];
        NSString * filePath = [bundlePath stringByAppendingPathComponent:relativePath];
        image = [UIImage imageWebPWithFilePath:filePath];
    }
    return image;
}

/*!
 *  @brief 指定bundle及bundle中的相对路径
 *
 *  @param bundleName   包名
 *  @param relativePath 包的相对路径
 *
 *  @return
 */
+ (UIImage *)imageWithBundleName:(NSString*)bundleName relativePath:(NSString *)relativePath{
    UIImage *image = nil;
    NSString * path = [UIImage relativePathWithBundleName:bundleName
                                             relativePath:relativePath];
    if (path && path.length>0) {
        image = [UIImage imageWithRelativePath:path];
    }
    return image;
}

#pragma mark -- other
/*!
 *  @brief 图片相对路径
 *
 *  @param bundleName   包名
 *  @param relativePath 图片在包中的相对路径
 *
 *  @return
 */
+(NSString*)relativePathWithBundleName:(NSString*)bundleName relativePath:(NSString*)relativePath{
    if (relativePath && [relativePath length] >0) {
        if (bundleName && bundleName.length >0) {
            NSString * dir = [NSString stringWithFormat:@"%@.bundle/",bundleName];
            NSString * path =[dir stringByAppendingString:relativePath];
            return path;
        }else{
            return relativePath;
        }
    }
    return nil;
}


@end
