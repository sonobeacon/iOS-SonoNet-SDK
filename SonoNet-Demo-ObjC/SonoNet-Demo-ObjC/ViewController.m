//
//  ViewController.m
//  SonoNet-Demo-ObjC
//
//  Created by Sascha Melcher on 26.03.19.
//  Copyright © 2019 SonoBeacon. All rights reserved.
//

#import "ViewController.h"


@import sonolib;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ContentView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SonoNet *sonoNet = [SonoNet shared];
    
    SonoNetConfig* config = [[SonoNetConfigBuilder alloc] initWithBuildClosure:^(SonoNetConfigBuilder * builder) {
      
    }];

    [sonoNet bindWithConfig:(config)];
    [sonoNet setWhenBluetoothDisabled:^{
        // do nothing so far
    }];
    
    [sonoNet setDidReceiveContent:^(id webLink) {
        NSString *title = [webLink title];
        NSLog(@"Title", title);
    }];
    
}


@end
