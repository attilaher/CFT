

#import "AppConstant.h"

#import "NavigationController.h"
#import "SettingViewController.h"
@implementation NavigationController
@synthesize imgLogo, btnRight;
//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];

    CGFloat nav_height  = self.navigationBar.frame.size.height;
    CGFloat stat_height = [UIApplication sharedApplication].statusBarFrame.size.height;;
    CGFloat nav_width   = [UIScreen mainScreen].bounds.size.width;
    
	self.navigationBar.barTintColor = HEXCOLOR(0xf7f7f7FF);
	self.navigationBar.tintColor = HEXCOLOR(0x2098d4ff);
	self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:HEXCOLOR(0xFFFFFFFF)};
	self.navigationBar.translucent = NO;
    //[self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBarBG"] forBarMetrics:UIBarMetricsDefault];
    
    UIImage* imglogo     = [UIImage imageNamed:@"logo_small.png"];
    float scale_for_logo = nav_height*0.7/imglogo.size.height;
    
    imgLogo       = [[UIImageView alloc] initWithFrame:CGRectMake(nav_width * 0.15f, stat_height+nav_height*0.15, imglogo.size.width*scale_for_logo, nav_height*0.7f)];
    imgLogo.image = imglogo;
    imgLogo.center = CGPointMake(nav_width*0.5f, imgLogo.center.y);
    [self.view addSubview:imgLogo];
    
    
    btnRight = [[UIButton alloc] initWithFrame:CGRectMake(nav_width-nav_height * 0.6f, stat_height + nav_height*0.3f, nav_height * 0.4f, nav_height * 0.4f)];
    [btnRight setBackgroundImage:[UIImage imageNamed:@"settings-icon.png"] forState:UIControlStateNormal];
    [btnRight setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [btnRight addTarget:self action:@selector(onClickUpButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btnRight];
}

-(void) setScreenMode:(NSString*) mode
{
    if ([mode isEqualToString:@"main"]) {
        [btnRight setHidden:YES];
    }else
        [btnRight setHidden:NO];
}

- (IBAction) onClickUpButton:(id)sender
{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SettingViewController* homeVC = [storyboard instantiateViewControllerWithIdentifier:@"setting"];
    [APP_DELEGATE.nav pushViewController:homeVC animated:YES];
}
@end
