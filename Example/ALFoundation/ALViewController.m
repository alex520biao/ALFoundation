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
#import <ALFoundation/UIImage+AssetLaunchImage.h>

@interface ALViewController ()


@end

@implementation ALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.multiDelegate = (GCDMulticastDelegate <MyDelegate> *)[[GCDMulticastDelegate alloc] init];
    
    ALObject *o1 = [[ALObject alloc] init];
    ALObject *o2 = [[ALObject alloc] init];
    
    [self.multiDelegate addDelegate:o1 delegateQueue:dispatch_get_main_queue()];
    [self.multiDelegate addDelegate:o2 delegateQueue:dispatch_get_main_queue()];

    //multiDelegate多播发送
    [self.multiDelegate test];
    
    UIImage *image1 = [UIImage imageWithBundleName:@"ALFoundation" relativePath:@"activity/activity_loading"];    
    UIImage *image2 = [UIImage imageWithRelativePath:@"ALFoundation.bundle/activity/activity_loading"];
    
    UIImage *image3 = ALFImage(@"activity/activity_loading");
    
    //asset中启动图
    UIImage *assetLaunchImage = [UIImage assetLaunchImage];

    NSLog(@"");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
