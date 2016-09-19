//
//  UIImage+ALSandbox.m
//  Pods
//
//  Created by liubiao on 16/9/19.
//
//

#import "UIImage+ALSandbox.h"

@implementation UIImage (ALSandbox)

#pragma mark -- ALLocal Sandbox沙盒中的图片
/*!
 *  @brief 应用本地沙盒documents目录绝对路径
 *
 *  @return
 */
+(NSString*)documentsPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

/*!
 *  @brief 应用本地沙盒Cache目录绝对路径
 *
 *  @return
 */
+(NSString*)cachePath{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
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
 *  @brief 获取Sandbox中的图片
 *
 *  @param type         沙盒目录类型
 *  @param relativePath 目录中的相对路径
 *
 *  @return
 */
+(UIImage*)imageWithSandboxType:(ALSandboxType)type relativePath:(NSString*)relativePath{
    NSString *filePath = [self imagePathInSandboxWithType:ALSandboxDocument relativePath:relativePath];
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    return img;
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
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    return img;
}

/*!
 *  @brief 将图片保存到sandbox沙盒中
 *
 *  @param sandboxImgPath 图片在沙盒中的绝对路径
 */
-(void)saveToSandboxWithAbsolutePath:(NSString*)sandboxImgPath{
    if(sandboxImgPath && sandboxImgPath.length > 0){
            //如果logsDirectoryPath目录不存在则创建
            BOOL isDirectory = NO;
            BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:sandboxImgPath isDirectory:&isDirectory];
            NSURL *url=[NSURL fileURLWithPath:sandboxImgPath];
            NSString *pathExtension = [url pathExtension];
            if (!isExist && pathExtension) {
                //删除最后一级文件名
                NSURL *pathURL = [url URLByDeletingLastPathComponent];
                NSData *data = UIImagePNGRepresentation(self);

                //目录不存在则递归创建目录
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
                NSLog(@"");
            }else{
                NSError *error=nil;
                BOOL x = [[NSFileManager defaultManager] removeItemAtPath:sandboxImgPath
                                                           error:&error];
                NSData *data = UIImagePNGRepresentation(self);
                BOOL ret = [[NSFileManager defaultManager] createFileAtPath:sandboxImgPath
                                                                   contents:nil
                                                                 attributes:nil];
                NSLog(@"");
            }
        
        
//        //向Sandbox保存图片
//        NSData *data = UIImagePNGRepresentation(self);
//        BOOL ret = [[NSFileManager defaultManager] createFileAtPath:sandboxImgPath
//                                                           contents:data
//                                                         attributes:nil];
//        NSArray *list = [[NSFileManager defaultManager] subpathsAtPath:sandboxImgPath];
//        if(ret){
//            //保存图片成功
//        }
        NSLog(@"");
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
