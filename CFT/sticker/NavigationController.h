

#import <UIKit/UIKit.h>

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface NavigationController : UINavigationController
//-------------------------------------------------------------------------------------------------------------------------------------------------
@property (strong, nonatomic) UIButton* btnRight;
@property (strong, nonatomic) UIImageView* imgLogo;

-(void) setScreenMode:(NSString*) mode;
@end
