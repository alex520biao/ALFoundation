//
//  ALViewController.m
//  ALFoundation
//
//  Created by alex520biao on 08/01/2016.
//  Copyright (c) 2016 alex520biao. All rights reserved.
//

#import "ALViewController.h"
#import "ALObject.h"
#import "ALFImage.h"
#import <ALFoundation/UIImage+ALAsset.h>
#import "UIImage+ALSandbox.h"
#import "UIImage+ALWebP.h"

@interface ALViewController ()


@end

@implementation ALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加multiDelegate绑定
    ALObject *o1 = [[ALObject alloc] init];
    ALObject *o2 = [[ALObject alloc] init];
    self.multiDelegate = (GCDMulticastDelegate <MyDelegate> *)[[GCDMulticastDelegate alloc] init];
    [self.multiDelegate addDelegate:o1 delegateQueue:dispatch_get_main_queue()];
    [self.multiDelegate addDelegate:o2 delegateQueue:dispatch_get_main_queue()];

    //multiDelegate多播发送
    [self.multiDelegate test];
    
    //读取本地Bundle图片:支持png、jpg、webp等格式
    UIImage *imageAll = [UIImage imageWithRelativePath:@"ALFoundation.bundle/activity/activity_loading@2x.png"];
    UIImage *image2 = [UIImage imageWithRelativePath:@"ALFoundation.bundle/activity/activity_loading"];
    UIImage *image1 = [UIImage imageWithBundleName:@"ALFoundation" relativePath:@"activity/activity_loading"];
    UIImage *image3 = ALFImage(@"activity/activity_loading");
    UIImage *imageBundleWebp = [UIImage imageWithRelativePath:@"ALFoundation.bundle/webp/bts_im_sad"];
    UIImage *imageBundleWebp1 = [UIImage imageWithRelativePath:@"ALFoundation.bundle/webp/bts_im_sad@2x.webp"];
    
//    //向ALSandboxDocument保存图片
//    [image3 saveToSandboxWithSanboxType:ALSandboxDocument relativePath:@"newImage1/image.png"];
//    //向ALSandboxCache保存图片
//    [image3 saveToSandboxWithSanboxType:ALSandboxCache relativePath:@"newImage1/image.png"];
//    //向ALSandboxTmp保存图片
//    [image3 saveToSandboxWithSanboxType:ALSandboxTmp relativePath:@"newImage1/image.png"];
    [imageBundleWebp saveToSandboxWithSanboxType:ALSandboxDocument relativePath:@"newImage1/bts_im_sad@2x.webp"];
    
    //获取SandboxDocuments目录图片
//    UIImage *sandboxImageDocuments = [UIImage imageInSandboxDocumentsWithRelativePath:@"newImage1/image.png"];
//    UIImage *sandboxImageCache = [UIImage imageWithSandboxType:ALSandboxCache relativePath:@"newImage1/image.png"];
//    UIImage *sandboxImageTmp = [UIImage imageWithSandboxType:ALSandboxTmp relativePath:@"newImage1/image.png"];
    UIImage *sandboxImageDocumentWebp = [UIImage imageWithSandboxType:ALSandboxDocument relativePath:@"newImage1/bts_im_sad@2x.webp"];

    //asset中启动图
    UIImage *assetLaunchImage = [UIImage assetLaunchImage];
    UIImage *assetIconImage = [UIImage assetIconImage];

    //测试断言
    //    int a = 4;
    //    ALAssert1(a==5, @"a应该为%d",5);    
    
    NSLog(@"");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
