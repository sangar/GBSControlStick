//
//  GSStick.m
//  BLEController
//
//  Created by Gard Sandholt on 4/8/13.
//  Copyright (c) 2013 GaSa Media. All rights reserved.
//

#import "GBSStick.h"

#define SIZE 44.f

@implementation GBSStick

- (id)init {
    return [self initWithFrame:CGRectMake(0.f, 0.f, SIZE, SIZE)];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0, 0, 255, 0.1);
    CGContextSetRGBStrokeColor(ctx, 0, 0, 255, 0.5);
    CGContextFillEllipseInRect(ctx, rect);
    CGContextStrokeEllipseInRect(ctx, CGRectMake(1.f, 1.f, SIZE-2.f, SIZE-2.f));
    CGContextFillPath(ctx);
}


@end
