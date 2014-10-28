//
//  ViewController.m
//  Example
//
//  Created by Gard Sandholt on 28/10/14.
//  Copyright (c) 2014 Gard Sandholt. All rights reserved.
//

#import "ViewController.h"
#import "GBSControlStick.h"

@interface ViewController ()

@property(nonatomic, strong) GBSControlStick *controlStick;

@property (weak, nonatomic) IBOutlet UILabel *xValLabel;
@property (weak, nonatomic) IBOutlet UILabel *yValLabel;


@property (weak, nonatomic) IBOutlet UILabel *leftFrontLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftBackLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightFrontLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightBackLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.controlStick = [[GBSControlStick alloc] initAtPoint:CGPointMake(self.view.center.x, 320.f) withDelegate:self];
    [self.view addSubview:self.controlStick];
}


#pragma mark -
#pragma mark BLEControlStick delegate methods

- (void)didUpdateValuesX:(CGFloat)x andY:(CGFloat)y {
    _xValLabel.text = [NSString stringWithFormat:@"%f", x];
    _yValLabel.text = [NSString stringWithFormat:@"%f", y];
}

- (void)didUpdateValuesTopLeft:(CGFloat)tl lowLeft:(CGFloat)ll lowRight:(CGFloat)lr topRight:(CGFloat)tr {
    _leftFrontLabel.text = [NSString stringWithFormat:@"%f", tl];
    _leftBackLabel.text = [NSString stringWithFormat:@"%f", ll];
    _rightBackLabel.text = [NSString stringWithFormat:@"%f", lr];
    _rightFrontLabel.text = [NSString stringWithFormat:@"%f", tr];
}

@end
