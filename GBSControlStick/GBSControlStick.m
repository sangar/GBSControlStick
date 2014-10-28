#import "GBSControlStick.h"
#import "GBSStick.h"

#define SIZE 225.f

@interface GBSControlStick ()

@property(nonatomic, strong) GBSStick *stick;
@property(nonatomic, strong) UIPanGestureRecognizer *stickGestureRecognizer;

@property CGFloat xValue, yValue;

- (void)resetStickView;
- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer;

- (CGFloat)stickSize;

- (void)resetValues;
- (void)updateValues;

@end


@implementation GBSControlStick

- (id)initAtPoint:(CGPoint)point withDelegate:(id)delegate {
    _delegate = delegate;
    return [self initAtPoint:point];
}

- (id)initAtPoint:(CGPoint)point {
    
    self = [self initWithFrame:CGRectMake(0.f, 0.f, SIZE, SIZE)];
    self.center = CGPointMake(point.x, point.y);
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        
        self.stickGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        
        [self.stick addGestureRecognizer:_stickGestureRecognizer];
        self.stick.center = CGPointMake(SIZE/2.f, SIZE/2.f);
        [self addSubview:self.stick];
    }
    return self;
}

- (GBSStick *)stick {
    if (!_stick) {
        _stick = [[GBSStick alloc] init];
    }
    return _stick;
}

- (CGFloat)stickSize {
    return _stick.frame.size.height;
}

- (void)resetValues {
    _xValue = _yValue = 0.f;
    [self updateValues];
}

- (void)resetStickView {
    [UIView animateWithDuration:0.3 animations:^{
        self.stick.center = CGPointMake(SIZE/2.f, SIZE/2.f);
    } completion:^(BOOL finished) {
        [self resetValues];
    }];
}


- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {

    CGFloat xOffset = 0.f;
    CGFloat yOffset = 0.f;
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:

            [self resetValues];
            
            xOffset = self.stick.center.x - [gestureRecognizer locationInView:self].x;
            yOffset = self.stick.center.y - [gestureRecognizer locationInView:self].y;
            
            break;
        case UIGestureRecognizerStateChanged:
            ;
            CGFloat distanceMovedX = ([gestureRecognizer locationInView:self].x + xOffset) - self.stick.center.x;
            CGFloat distanceMovedY = ([gestureRecognizer locationInView:self].y + yOffset) - self.stick.center.y;
            
            CGPoint stickCenter = _stick.center;
            
            CGFloat newX = stickCenter.x + distanceMovedX;
            CGFloat newY = stickCenter.y + distanceMovedY;
            
            if (newX >= 0.f+([self stickSize]/2.f) && newX <= SIZE-([self stickSize]/2.f)) {
                
                _xValue = ((SIZE/2.f)-newX) / ((SIZE/2.f)-(self.stickSize/2.f));
                
                stickCenter.x = newX;
            }
            if (newY >= 0.f+([self stickSize]/2.f) && newY <= SIZE-([self stickSize]/2.f)) {
                
                _yValue = ((SIZE/2.f)-newY) / ((SIZE/2.f)-(self.stickSize/2.f));
                
                stickCenter.y = newY;
            }
            [self updateValues];
            
            _stick.center = stickCenter;
            
            break;
        default:
            [self resetStickView];
            break;
    }
}

static UInt8 lastTopLeftVal = -1, lastTopRightVal = -1, lastLowLeftVal = -1, lastLowRightVal = -1;

- (void)updateValues {
    if ([_delegate respondsToSelector:@selector(didUpdateValuesX:andY:)]) {
        [_delegate didUpdateValuesX:_xValue andY:_yValue];
    }
    if ([_delegate respondsToSelector:@selector(didUpdateValuesTopLeft:lowLeft:lowRight:topRight:)]) {
        
        CGFloat y = _yValue;
        CGFloat x = _xValue;
        
        CGFloat topLeftVal = 0.f;
        CGFloat topRightVal = 0.f;
        CGFloat lowLeftVal = 0.f;
        CGFloat lowRightVal = 0.f;
        
        if (y >= 0.f) {
            topLeftVal = (y-(-x) > 1.f ? 1.f : y-(-x)) * 255.f;
            topRightVal = (y-x > 1.f ? 1.f : y-x) * 255.f;
            
            if (topLeftVal <= 0.f) {
                topLeftVal = 0.f;
            }
            if (topLeftVal > 255.f) {
                topLeftVal = 255.f;
            }
            if (topRightVal <= 0.f) {
                topRightVal = 0.f;
            }
            if (topRightVal > 255.f) {
                topRightVal = 255.f;
            }
        } else {
            lowLeftVal = (-y-(-x) > 1.f ? 1.f : -y-(-x))*255.f;
            lowRightVal = (-y-x > 1.f ? 1.f : -y-x)*255.f;
            
            if (lowLeftVal <= 0.f) {
                lowLeftVal = 0.f;
            }
            if (lowLeftVal > 255.f) {
                lowLeftVal = 255.f;
            }
            if (lowRightVal <= 0.f) {
                lowRightVal = 0.f;
            }
            if (lowRightVal > 255.f) {
                lowRightVal = 255.f;
            }
        }

        if (lastTopLeftVal != topLeftVal || lastTopRightVal != topRightVal || lastLowLeftVal != lowLeftVal || lastLowRightVal != lowRightVal) {
            
            [_delegate didUpdateValuesTopLeft:topLeftVal lowLeft:lowLeftVal lowRight:lowRightVal topRight:topRightVal];
        
            lastTopLeftVal = topLeftVal; lastTopRightVal = topRightVal;
            lastLowLeftVal = lowLeftVal; lastLowRightVal = lowRightVal;
        }
    }
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect:(CGRect)rect: %@", NSStringFromCGRect(rect));
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.1);
    CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 0.5);
    CGContextFillEllipseInRect(ctx, rect);
    CGContextStrokeEllipseInRect(ctx, CGRectMake(1.f, 1.f, SIZE-2.f, SIZE-2.f));
}

@end
