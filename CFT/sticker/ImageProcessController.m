//
//  ImageProcessController.m
//  CFT
//
//  Created by Must on 3/5/16.
//  Copyright © 2016 Must. All rights reserved.
//

#import "ImageProcessController.h"
#import "UIImage+Resize.h"
#import "TOCropViewController.h"
#import "UIImage+CropRotate.h"
#import "UIImage+Rotating.h"

#define TAG_SCALE_BTN       1001
#define TAG_ROTATE_BTN      1101


typedef enum {
    PW_NULL,
    PW_BRIGHTNESS,
    PW_CONTRAST,
    PW_ROTATION,
    PW_CROP
}PROCESS_WND;


@implementation ImageProcessController
{
    float           m_brightness;
    float           m_contrast;
    PROCESS_WND     m_currentWnd;
    PROCESS_WND     m_oldWnd;
    UIImage*        m_OriginalImage;
    UIImageView*    m_WorkingImageView;
    UIImage*        m_WorkingImage;

    IBOutlet UISlider *m_Slider;
}



-(void) viewDidLoad{
    [super viewDidLoad];
    if (self.m_OriginalImageData == nil)
        return;

    m_OriginalImage = [[UIImage imageWithData:self.m_OriginalImageData] resizedImageToFitInSize:CGSizeMake(1024, 1024) scaleIfSmaller:NO];
    self.m_ImageView = [self.m_ImageView initWithImage:m_OriginalImage];
    self.gpuImageSource = [[GPUImagePicture alloc] initWithImage:m_OriginalImage];
}

-(void) viewDidAppear:(BOOL)animated{
    [self.m_ImageView layoutInitialImage];
    [self initialize];
}

-(void) initialize{
    self.m_ScaleContainer.hidden = false;
    self.m_RotationContainer.hidden = true;
    self.m_SliderContainer.hidden = true;
    self.m_ImageContainer.hidden = true;
    m_WorkingImageView = nil;
    m_WorkingImage = nil;
    m_currentWnd = PW_CROP;
    m_oldWnd = PW_CROP;
    m_brightness = 0.0f;
    m_contrast = 2.0f;
}

- (IBAction)onClickBrightness:(id)sender {
    self.m_ImageContainer.hidden = false;
    self.m_ImageView.hidden = true;
    self.m_ScaleContainer.hidden = true;
    self.m_RotationContainer.hidden = true;
    self.m_SliderContainer.hidden = false;
    [m_Slider setValue:(m_brightness + 1) / 2];
    
    m_oldWnd = m_currentWnd;
    m_currentWnd = PW_BRIGHTNESS;
    [self cropImage];
    self.
    self.gpuImageSource = [self.gpuImageSource initWithImage:m_WorkingImage];
    
}

- (IBAction)onClickContrast:(id)sender {
    [m_Slider setValue:0.5f];
    self.m_ImageContainer.hidden = false;
    self.m_ImageView.hidden = true;
    self.m_ScaleContainer.hidden = true;
    self.m_RotationContainer.hidden = true;
    self.m_SliderContainer.hidden = false;
    [m_Slider setValue:m_contrast / 4.0f];
    
    m_oldWnd = m_currentWnd;
    m_currentWnd = PW_CONTRAST;
    [self cropImage];
    _gpuImageSource = [_gpuImageSource initWithImage:m_WorkingImage];
}

- (IBAction)onClickRotation:(id)sender {
    self.m_ImageContainer.hidden = false;
    self.m_ImageView.hidden = true;
    self.m_ScaleContainer.hidden = true;
    self.m_RotationContainer.hidden = false;
    self.m_SliderContainer.hidden = true;
    m_oldWnd = m_currentWnd;
    m_currentWnd = PW_ROTATION;
    [self cropImage];
    _gpuImageSource = [_gpuImageSource initWithImage:m_WorkingImage];
}

- (IBAction)onClickCrop:(id)sender {
    self.m_ImageContainer.hidden = true;
    self.m_ImageView.hidden = false;
    self.m_ScaleContainer.hidden = false;
    self.m_RotationContainer.hidden = true;
    self.m_SliderContainer.hidden = true;
    m_oldWnd = m_currentWnd;
    m_currentWnd = PW_CROP;
    
    if (m_oldWnd != PW_CROP){
        m_WorkingImage = [m_WorkingImage resizedImageToFitInSize:CGSizeMake(1024, 1024) scaleIfSmaller:NO];
        [self.m_ImageView setNewImage:m_WorkingImage];
        [self.m_ImageView layoutInitialImage];
        [self.m_ImageView setAspectLockEnabledWithAspectRatio:CGSizeZero animated:true];
    }
}



-(void) cropImage{
    if (m_oldWnd != PW_CROP || m_oldWnd == m_currentWnd)
        return;

    m_WorkingImage = [m_OriginalImage croppedImageWithFrame:self.m_ImageView.croppedImageFrame angle:self.m_ImageView.angle];
    if (m_WorkingImage == nil)
        return;
    
    if (m_WorkingImageView == nil){
        m_WorkingImageView = [[UIImageView alloc] initWithImage:m_WorkingImage];
        [m_WorkingImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.m_ImageContainer addSubview:m_WorkingImageView];
    }
    else{
        [m_WorkingImageView setImage:m_WorkingImage];
    }
    [self layoutWorkingImageView];
}

-(void) layoutWorkingImageView{
    CGSize size = m_WorkingImage.size;
    CGRect newFrame = CGRectZero;
    
    if (size.width > size.height){
        newFrame.size.width = self.m_ImageContainer.frame.size.width * 0.9f;
        newFrame.size.height = newFrame.size.width * size.height / size.width;
    }
    else{
        newFrame.size.height = self.m_ImageContainer.frame.size.height * 0.9f;
        newFrame.size.width = newFrame.size.height * size.width / size.height;
    }
    
    newFrame.origin.x = (self.m_ImageContainer.frame.size.width - newFrame.size.width) / 2 ;
    newFrame.origin.y = (self.m_ImageContainer.frame.size.height - newFrame.size.height) / 2;

    [m_WorkingImageView setFrame:newFrame];
}


- (IBAction)onClickScaleButton:(UIButton *)sender {
    NSInteger tag = sender.tag;
    CGSize aspectRatio = CGSizeZero;
    
    switch (tag) {
        case TAG_SCALE_BTN + 1:
            aspectRatio = CGSizeMake(3.0f, 2.0f);
            break;
        case TAG_SCALE_BTN + 2:
            aspectRatio = CGSizeMake(4.0f, 3.0f);
            break;
        case TAG_SCALE_BTN + 3:
            aspectRatio = CGSizeMake(5.0f, 4.0f);
            break;
        case TAG_SCALE_BTN + 4:
            aspectRatio = CGSizeMake(1.0f, 1.0f);
            break;
        case TAG_SCALE_BTN + 5:
            aspectRatio = CGSizeMake(3.0f, 4.0f);
            break;
        case TAG_SCALE_BTN + 6:
            aspectRatio = CGSizeMake(2.0f, 3.0f);
            break;
        default:
            aspectRatio = CGSizeMake(0.0f, 0.0f);
            break;
    }
    
    if (self.m_ImageView.cropBoxAspectRatioIsPortrait){
        CGFloat width = aspectRatio.width;
        aspectRatio.width = aspectRatio.height;
        aspectRatio.height = width;
    }
    
    [self.m_ImageView setAspectLockEnabledWithAspectRatio:aspectRatio animated:true];
}

- (IBAction)onClickRotationButton:(id)sender {
    if (self.m_ImageContainer.hidden == true)
        return;
    
    NSInteger tag = ((UIButton*) sender).tag;
    switch (tag) {
        case TAG_ROTATE_BTN://left
            m_WorkingImage = [m_WorkingImage rotateInDegrees:-90];
            break;
        case TAG_ROTATE_BTN + 1://right
            m_WorkingImage = [m_WorkingImage rotateInDegrees:90];
            break;
        case TAG_ROTATE_BTN + 2://horizontal
            m_WorkingImage = [m_WorkingImage horizontalFlip];
            break;
        case TAG_ROTATE_BTN + 3://vertical
            m_WorkingImage = [m_WorkingImage verticalFlip];
            break;
        default:
            return;
    }
    
    [m_WorkingImageView setImage:m_WorkingImage];

    [self layoutWorkingImageView];
    
}

- (IBAction)onChangeSlider:(id)sender {
    UISlider* slider = (UISlider*) sender;
    float value = slider.value;
    
    if (m_currentWnd == PW_BRIGHTNESS){
        GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
        
        value -= 0.5f;
        value *= 2.0f;
        m_brightness = value;
        
        [_gpuImageSource addTarget:brightnessFilter];
        // -1.0~1.0
        [brightnessFilter setBrightness:m_brightness];
        [brightnessFilter useNextFrameForImageCapture];
        [_gpuImageSource processImage];
        m_WorkingImage = [brightnessFilter imageFromCurrentFramebuffer];
    }
    else if (m_currentWnd == PW_CONTRAST){
        GPUImageContrastFilter *contrastFilter = [[GPUImageContrastFilter alloc] init];
        [_gpuImageSource addTarget:contrastFilter];
        
        m_contrast = (value + 1) * 2.0f;
        // 0 ~4.0
        [contrastFilter setContrast:m_contrast];
        [contrastFilter useNextFrameForImageCapture];
        [_gpuImageSource processImage];
        m_WorkingImage = [contrastFilter imageFromCurrentFramebuffer];
    }
    
    [m_WorkingImageView setImage:m_WorkingImage];
    [self layoutWorkingImageView];
}



@end
