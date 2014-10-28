#import <UIKit/UIKit.h>

//! Project version number for GBSControlStick.
FOUNDATION_EXPORT double GBSControlStickVersionNumber;

//! Project version string for GBSControlStick.
FOUNDATION_EXPORT const unsigned char GBSControlStickVersionString[];


@protocol GBSControlStickDelegate <NSObject>

@optional
- (void)didUpdateValuesX:(CGFloat)x andY:(CGFloat)y;
- (void)didUpdateValuesTopLeft:(CGFloat)tl lowLeft:(CGFloat)ll lowRight:(CGFloat)lr topRight:(CGFloat)tr;

@end


@interface GBSControlStick : UIView

@property(nonatomic, strong) id<GBSControlStickDelegate> delegate;

- (id)initAtPoint:(CGPoint)point withDelegate:(id)delegate;

@end


