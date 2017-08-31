//
//  ViewController.m
//  ProgresssLineLayerDemo
//
//  Created by 吴珂 on 2017/8/31.
//  Copyright © 2017年 世纪阳天. All rights reserved.
//

#import "ViewController.h"
#import "WKProgressBarLayer.h"

@interface ViewController ()

@property (nonatomic, strong) WKProgressBarLayer *progressLayer;

@property (weak, nonatomic) IBOutlet UIButton *startOrPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
- (IBAction)startOrPauseAction:(UIButton *)sender;
- (IBAction)resetAction:(UIButton *)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKProgressBarLayer *progressLayer = [[WKProgressBarLayer alloc] init];
    progressLayer.frame = CGRectMake(100, 100, 200, 10);
    
    [self.view.layer addSublayer:progressLayer];
    
    self.progressLayer = progressLayer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startOrPauseAction:(UIButton *)sender {
        switch (self.progressLayer.animatingStatus) {
            case WKAnimationStatusIdle:{
                [self.progressLayer beginAnimationWithDuration:10];
            }
                
                break;
            case WKAnimationStatusAnimating:{
                [self.progressLayer pauseAnimation];
            }
                
                break;
            case WKAnimationStatusPause:{
                [self.progressLayer resumeAnimation];
            }
                
                break;
            case WKAnimationStatusComplete:{
                [self.progressLayer restartAnimationWithProgress:0 duration:10];
            }
                break;
                
            default:
                break;
    }
    sender.selected = !sender.selected;
}

- (IBAction)resetAction:(UIButton *)sender {
    [self.progressLayer restartAnimationWithProgress:0 duration:10];
    self.startOrPauseButton.selected = YES;
}
@end
