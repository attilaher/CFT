//
//  TutorialViewController.m
//  sticker
//
//  Created by iT on 10/29/15.
//  Copyright © 2015 LiuZiyang. All rights reserved.
//

#import "TutorialViewController.h"
#import "AppConstant.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

-(void)viewWillAppear:(BOOL)animated
{
    [APP_DELEGATE.nav setScreenMode:@"tutorial"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"intro1.png"] description:@""];
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"intro2.png"] description:@""];
    MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"intro3.png"] description:@""];
    MYIntroductionPanel *panel4 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"intro4.png"] description:@""];
    MYIntroductionPanel *panel5 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"intro5.png"] description:@""];
    MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) headerText:@"MYIntroductionView" panels:@[panel1, panel2,panel3, panel4, panel5] languageDirection:MYLanguageDirectionLeftToRight];
    
    [introductionView setBackgroundImage:[UIImage imageNamed:@"tutorial-back.png"]];
    //Set delegate to self for callbacks (optional)
    introductionView.delegate = self;
    //STEP 3: Show introduction view
    [introductionView showInView:self.view];
}

-(void)introductionDidFinishWithType:(MYFinishType)finishType
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
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
