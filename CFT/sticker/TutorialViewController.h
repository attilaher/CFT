//
//  TutorialViewController.h
//  sticker
//
//  Created by iT on 10/29/15.
//  Copyright © 2015 LiuZiyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYIntroductionView.h"
@interface TutorialViewController : UIViewController<UIScrollViewDelegate, MYIntroductionDelegate>
@property (nonatomic,retain) IBOutlet UIScrollView* scrollview;
@property (nonatomic,retain) IBOutlet UIImageView* imgtutorial;

@property (nonatomic,retain) IBOutlet NSLayoutConstraint * constraintWidth;
@property (nonatomic,retain) IBOutlet NSLayoutConstraint * constraintHeight;
@end
