//
//  UIImage+ALBundle.m
//  Pods
//
//  Created by alex520biao on 15/11/13. Maintain by alex520biao
//
//

#import "UIImage+ALBundle.h"
#import "UIImage+ALWebP.h"

@implementation UIImage (ALBundle)


#pragma mark -- 加载ALBundle本地包中的图片
/*!
 *  @brief 使用相对路径加载图片
 *
 *  @param relativePath app的mainBundle相对路径    @"ALFoundation.bundle/activity/activity_loading"
 *
 *  @return
 */
+(UIImage*)imageWithRelativePath:(NSString*)relativePath{
    UIImage *image = nil;
    if (relativePath && relativePath.length>0) {
        //优先使用[UIImage imageNamed:]读取png/jpg等系统支持格式
        image = [UIImage imageNamed:relativePath];
        
        //无png、jpg图片,则检查其他更多图片格式: 如WebP格式
        if (!image) {
            image = [UIImage imageWebPWithRelativePath:relativePath];
        }
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
        image = [UIImage imageNamed:path];
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
