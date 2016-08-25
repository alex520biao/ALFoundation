//
//  UIImage+ALLocal.m
//  Pods
//
//  Created by liubiao on 15/11/13. Maintain by liubiao
//
//

#import "UIImage+ALLocal.h"


@implementation UIImage (ALLocal)


/*!
 *  @brief 使用相对路径加载图片
 *
 *  @param relativePath app的mainBundle相对路径    @"ALFoundation.bundle/activity/activity_loading"
 *
 *  @return
 */
+(UIImage*)imageWithRelativePath:(NSString*)relativePath{
    if (relativePath && relativePath.length>0) {
        return [UIImage imageNamed:relativePath];
    }
    return nil;
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
    NSString * path = [UIImage imageRelativePathWithBundleName:bundleName
                                                  relativePath:relativePath];
    if (path && path.length>0) {
        image = [UIImage imageNamed:path];
    }
    return image;
}

/*!
 *  @brief 图片相对路径
 *
 *  @param bundleName   包名
 *  @param relativePath 图片在包中的相对路径
 *
 *  @return
 */
+(NSString*)imageRelativePathWithBundleName:(NSString*)bundleName relativePath:(NSString*)relativePath{
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
