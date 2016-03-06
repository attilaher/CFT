//
//  HomeViewController.h
//  sticker
//
//  Created by iT on 10/29/15.
//  Copyright © 2015 LiuZiyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOCropViewController.h"


@interface HomeViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,TOCropViewControllerDelegate>
@property (readwrite) int nMode;

@end
