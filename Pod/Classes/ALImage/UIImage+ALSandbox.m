//
//  UIImage+ALSandbox.m
//  Pods
//
//  Created by alex520biao on 16/9/19.
//
//

#import "UIImage+ALSandbox.h"
#import "UIImage+ALWebP.h"
#import "NSData+ImageContentType.h"

@implementation UIImage (ALSandbox)

#pragma mark -- 加载ALSandbox沙盒中的图片
/*!
 *  @brief 获取Sandbox中的图片
 *
 *  @param type         沙盒目录类型
 *  @param relativePath 目录中的相对路径
 *
 *  @return
 */
+(UIImage*)imageWithSandboxType:(ALSandboxType)type relativePath:(NSString*)relativePath{
    NSString *filePath = [self imagePathInSandboxWithType:ALSandboxDocument relativePath:relativePath];
    //优先读取png、jpg
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    //读取webp格式图片
    if(!image){
        image = [UIImage imageWebPWithFilePath:filePath];
    }
    return image;
}

/*!
 *  @brief 读取SandboxDocuments目录中的图片
 *
 *  @param relativePath 图片在SandboxDocuments目录的相对录几个
 *  @note  如relativePath为newImage/pin.png，则最后图片本地绝对路径为/Users/apple/Library/Application Support/iPhone Simulator/4.3/Applications/550AF26D-174B-42E6-881B-B7499FAA32B7/Documents/newImage/pin.png
 *
 *  @return
 */
+(UIImage*)imageInSandboxDocumentsWithRelativePath:(NSString*)relativePath{
    NSString *filePath = [self imagePathInSandboxWithType:ALSandboxDocument relativePath:relativePath];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    //读取webp格式图片
    if(!image){
        image = [UIImage imageWebPWithFilePath:filePath];
    }
    return image;
}

#pragma mark - other
/*!
 *  @brief 应用本地沙盒documents目录绝对路径
 *
 *  @return
 */
+(NSString*)documentsPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}

/*!
 *  @brief 应用本地沙盒Cache目录绝对路径
 *
 *  @return
 */
+(NSString*)cachePath{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths firstObject];
    return cachesDirectory;
}

/*!
 *  @brief 应用本地沙盒tmp目录绝对路径
 *
 *  @return
 */
+(NSString*)tmpPath{
    NSString *tmpDirectory=[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    return tmpDirectory;
}

/*!
 *  @brief 获取Sandbox图片本地绝对路径
 *
 *  @param type         沙盒目录类型
 *  @param relativePath 图片在沙盒目录中的相对路径
 *
 *  @return 图片文件在沙盒中的绝对路径
 */
+(NSString*)imagePathInSandboxWithType:(ALSandboxType)type relativePath:(NSString*)relativePath{
    NSString *filePath = nil;
    if (type == ALSandboxDocument) {
        NSString *documentsDirectory = [self documentsPath];
        filePath = [documentsDirectory stringByAppendingPathComponent:relativePath];
    }else if (type == ALSandboxCache){
        NSString *documentsDirectory = [self cachePath];
        filePath = [documentsDirectory stringByAppendingPathComponent:relativePath];
    }else if (type == ALSandboxTmp){
        NSString *tmpPath = [self tmpPath];
        filePath = [tmpPath stringByAppendingPathComponent:relativePath];
    }
    return filePath;
}

/*!
 *  @brief 判断fielPath路径指向文件是否存在
 *
 *  @param fielPath 文件的本地绝对路径
 *
 *  @return
 */
+(BOOL)fileExistsAtPath:(NSString*)fielPath{
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:fielPath];
    return blHave;
}

/*!
 *  @brief 将图片保存到sandbox沙盒中
 *
 *  @param sandboxImgPath 图片在沙盒中的绝对路径
 */
-(void)saveToSandboxWithAbsolutePath:(NSString*)sandboxImgPath{
    if(sandboxImgPath && sandboxImgPath.length > 0){
            BOOL isDirectory = NO;
            BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:sandboxImgPath isDirectory:&isDirectory];
            NSURL *url=[NSURL fileURLWithPath:sandboxImgPath];
            NSString *pathExtension = [url pathExtension];
            //文件名必须包含png、jpg、webp图片后缀
            if (pathExtension) {
                NSData *data = nil;
                if([pathExtension isEqualToString:@"png"]){
                    data = UIImagePNGRepresentation(self);
                }else if ([pathExtension isEqualToString:@"jpg"] ||[pathExtension isEqualToString:@"jpeg"]){
                    data = UIImageJPEGRepresentation(self,1.0);
                }else if ([pathExtension isEqualToString:@"webp"]){
                    data = [self dataWebPWithQuality:100];
//                    NSString *type = [NSData sd_contentTypeForImageData:data];
                }
                
                if(!data){
                    return;
                }

                //得到文件所在目录,目录不存在则递归创建目录
                NSURL *pathURL = [url URLByDeletingLastPathComponent];
                if(![[NSFileManager defaultManager] fileExistsAtPath:[pathURL absoluteString]]){
                    NSError *error=nil;
                    //递归创建目录
                    BOOL y = [[NSFileManager defaultManager] createDirectoryAtPath:sandboxImgPath
                                                       withIntermediateDirectories:YES
                                                                        attributes:nil
                                                                             error:&error];
                    if (error) {
                        //创建失败
                    }
                }
                
                //存在则删除
                if([[NSFileManager defaultManager] fileExistsAtPath:sandboxImgPath]){
                    //递归创建目录
                    NSError *error = nil;
                    BOOL y = [[NSFileManager defaultManager] removeItemAtPath:sandboxImgPath
                                                                        error:&error];
                    if(error){
                        NSLog(@"");
                    }
                }

                
                BOOL ret = [[NSFileManager defaultManager] createFileAtPath:sandboxImgPath
                                                                   contents:data
                                                                 attributes:nil];
            }
    }
}

/*!
 *  @brief 将图片保存到sandbox沙盒中
 *
 *  @param type         沙盒目录类型
 *  @param relativePath 图片在沙盒目录内部的相对路径,包含文件全名。如image.png或newImage/image.png
 */
-(void)saveToSandboxWithSanboxType:(ALSandboxType)type  relativePath:(NSString*)relativePath{
    NSString *sandboxFilePath = nil;
    if(type == ALSandboxDocument){
        //向ALSandboxDocument保存图片
        sandboxFilePath = [UIImage imagePathInSandboxWithType:ALSandboxDocument relativePath:relativePath];
    }else if (type == ALSandboxCache){
        //向ALSandboxCache保存图片
        sandboxFilePath = [UIImage imagePathInSandboxWithType:ALSandboxCache relativePath:relativePath];
    }else if (type == ALSandboxTmp){
        //向ALSandboxTmp保存图片
        sandboxFilePath = [UIImage imagePathInSandboxWithType:ALSandboxTmp relativePath:relativePath];
    }
    [self saveToSandboxWithAbsolutePath:sandboxFilePath];
}


@end
