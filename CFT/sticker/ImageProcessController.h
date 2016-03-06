//
//  ImageProcessController.h
//  CFT
//
//  Created by Must on 3/5/16.
//  Copyright © 2016 Must. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOCropView.h"
#import "GPUImage.h"
#import "GPUImageBrightnessFilter.h"
#import "GPUImageContrastFilter.h"

@interface ImageProcessController : UIViewController

@property (nonatomic, copy) NSData* m_OriginalImageData;


@property (strong, nonatomic) IBOutlet TOCropView *m_ImageView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *m_BarButton;

@property (weak, nonatomic) IBOutlet UIButton *m_BrightnessBtn;
@property (weak, nonatomic) IBOutlet UIButton *m_ContrastBtn;
@property (weak, nonatomic) IBOutlet UIButton *m_RotationBtn;
@property (weak, nonatomic) IBOutlet UIButton *m_CropBtn;

@property (strong, nonatomic) IBOutlet UIView *m_SliderContainer;
@property (strong, nonatomic) IBOutlet UIView *m_RotationContainer;
@property (strong, nonatomic) IBOutlet UIView *m_ScaleContainer;

@property (strong, nonatomic) IBOutlet UIView *m_ImageContainer;

@property (strong, nonatomic) GPUImagePicture *gpuImageSource;
@end
