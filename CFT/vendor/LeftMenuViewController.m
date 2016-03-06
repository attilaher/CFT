//
//  LeftMenuViewController.m
//  sticker
//
//  Created by iT on 10/29/15.
//  Copyright © 2015 LiuZiyang. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "AppConstant.h"
#import "HomeViewController.h"
#import "TutorialViewController.h"
#import "SettingViewController.h"
#import "NavigationController.h"
@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController
-(void)viewWillAppear:(BOOL)animated
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.lblHome setTextColor:HEXCOLOR(0xf27334ff)];
    [self.imgHome setImage:[UIImage imageNamed:@"home-icon001-hover.png"]];
}

-(IBAction)onTapClose:(id)sender
{
    [APP_DELEGATE.sideviewController toggleLeftPanel:self];
}

-(IBAction)onTapButton:(id)sender
{
    UIButton* tmpButton = (UIButton*)sender;
    APP_DELEGATE.selectedMenu = tmpButton.tag;
    
    // Do any additional setup after loading the view.
    [self.lblCamera setTextColor:HEXCOLOR(0x2098d4ff)];
    [self.lblHome setTextColor:HEXCOLOR(0x2098d4ff)];
    [self.lblGallery setTextColor:HEXCOLOR(0x2098d4ff)];
    [self.lblEditing setTextColor:HEXCOLOR(0x2098d4ff)];
    [self.lblTutorial setTextColor:HEXCOLOR(0x2098d4ff)];
    [self.lblSettings setTextColor:HEXCOLOR(0x2098d4ff)];
    
    [self.imgHome setImage:[UIImage imageNamed:@"home-icon001-normal.png"]];
    [self.imgCamera setImage:[UIImage imageNamed:@"camera-icon002-normal.png"]];
    [self.imgGallery setImage:[UIImage imageNamed:@"gallery-icon003-normal.png"]];
    [self.imgEditing setImage:[UIImage imageNamed:@"Editing-icon004-normal.png"]];
    [self.imgTutorial setImage:[UIImage imageNamed:@"tutorial-icon005-normal.png"]];
    [self.imgSettings setImage:[UIImage imageNamed:@"settings-icon006-normal.png"]];
    
    switch (APP_DELEGATE.selectedMenu) {
        case 0:
            [self.lblHome setTextColor:HEXCOLOR(0xf27334ff)];
            [self.imgHome setImage:[UIImage imageNamed:@"home-icon001-hover.png"]];
            break;
            
        case 1:
            [self.lblCamera setTextColor:HEXCOLOR(0xf27334ff)];
            [self.imgCamera setImage:[UIImage imageNamed:@"camera-icon002-hover.png"]];
            break;
            
        case 2:
            [self.lblGallery setTextColor:HEXCOLOR(0xf27334ff)];
            [self.imgGallery setImage:[UIImage imageNamed:@"gallery-icon003-hover.png"]];
            break;
            
        case 3:
            [self.lblEditing setTextColor:HEXCOLOR(0xf27334ff)];
            [self.imgEditing setImage:[UIImage imageNamed:@"Editing-icon004-hover.png"]];
            break;
            
        case 4:
            [self.lblTutorial setTextColor:HEXCOLOR(0xf27334ff)];
            [self.imgTutorial setImage:[UIImage imageNamed:@"tutorial-icon005-hover.png"]];
            break;
            
        case 5:
            [self.lblSettings setTextColor:HEXCOLOR(0xf27334ff)];
            [self.imgSettings setImage:[UIImage imageNamed:@"settings-icon006-hover.png"]];
            break;
            
        default:
            break;
    }
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    switch (tmpButton.tag) {
        case 0:
        {
            HomeViewController* homeVC = [storyboard instantiateViewControllerWithIdentifier:@"home"];
            APP_DELEGATE.nav = [[NavigationController alloc] initWithRootViewController:homeVC];
            APP_DELEGATE.sideviewController.centerPanel = APP_DELEGATE.nav;
            [APP_DELEGATE.sideviewController toggleLeftPanel:self];
            break;
        }
        case 1:
        {
            HomeViewController* homeVC = [storyboard instantiateViewControllerWithIdentifier:@"home"];
            homeVC.nMode = 1;
            APP_DELEGATE.nav = [[NavigationController alloc] initWithRootViewController:homeVC];
            APP_DELEGATE.sideviewController.centerPanel =APP_DELEGATE.nav;
            [APP_DELEGATE.sideviewController toggleLeftPanel:self];
            break;
        }
        case 2:
        {
            HomeViewController* homeVC = [storyboard instantiateViewControllerWithIdentifier:@"home"];
            homeVC.nMode = 2;
            APP_DELEGATE.nav = [[NavigationController alloc] initWithRootViewController:homeVC];
            APP_DELEGATE.sideviewController.centerPanel = APP_DELEGATE.nav;
            [APP_DELEGATE.sideviewController toggleLeftPanel:self];
            break;
        }
        case 3:
        {
            UIViewController *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"mainview"];
            APP_DELEGATE.nav = [[NavigationController alloc] initWithRootViewController:mainVC];
            APP_DELEGATE.sideviewController.centerPanel = APP_DELEGATE.nav;
            break;
        }
        case 4:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TutorialViewController *tradeVC = [storyboard instantiateViewControllerWithIdentifier:@"tutorial"];
            [self presentViewController:tradeVC animated:NO completion:^{}];
            [APP_DELEGATE.sideviewController toggleLeftPanel:self];
            break;
        }
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
