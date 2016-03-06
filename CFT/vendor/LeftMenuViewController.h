//
//  LeftMenuViewController.h
//  sticker
//
//  Created by iT on 10/29/15.
//  Copyright © 2015 LiuZiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuViewController : UIViewController
@property (nonatomic, retain) IBOutlet UIImageView* imgHome;
@property (nonatomic, retain) IBOutlet UIImageView* imgCamera;
@property (nonatomic, retain) IBOutlet UIImageView* imgGallery;
@property (nonatomic, retain) IBOutlet UIImageView* imgEditing;
@property (nonatomic, retain) IBOutlet UIImageView* imgTutorial;
@property (nonatomic, retain) IBOutlet UIImageView* imgSettings;

@property (nonatomic, retain) IBOutlet UILabel* lblHome;
@property (nonatomic, retain) IBOutlet UILabel* lblCamera;
@property (nonatomic, retain) IBOutlet UILabel* lblGallery;
@property (nonatomic, retain) IBOutlet UILabel* lblEditing;
@property (nonatomic, retain) IBOutlet UILabel* lblTutorial;
@property (nonatomic, retain) IBOutlet UILabel* lblSettings;

@end
