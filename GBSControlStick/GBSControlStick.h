#import <UIKit/UIKit.h>

//! Project version number for BLEControlStick.
FOUNDATION_EXPORT double BLEControlStickVersionNumber;

//! Project version string for BLEControlStick.
FOUNDATION_EXPORT const unsigned char BLEControlStickVersionString[];


@protocol GBSControlStickDelegate <NSObject>

@optional
- (void)didUpdateValuesX:(CGFloat)x andY:(CGFloat)y;
- (void)didUpdateValuesTopLeft:(CGFloat)tl lowLeft:(CGFloat)ll lowRight:(CGFloat)lr topRight:(CGFloat)tr;

@end


@interface GBSControlStick : UIView

@property(nonatomic, strong) id<GBSControlStickDelegate> delegate;

- (id)initAtPoint:(CGPoint)point withDelegate:(id)delegate;

@end


