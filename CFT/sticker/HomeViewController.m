//
//  HomeViewController.m
//  sticker
//
//  Created by iT on 10/29/15.
//  Copyright © 2015 LiuZiyang. All rights reserved.
//

#import "HomeViewController.h"
#import "TutorialViewController.h"
#import "UIImage+Resize.h"
#import "AppConstant.h"
#import "SettingViewController.h"
#import "UIImage+PRAutoAdjust.h"
#import "ImageProcessController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [APP_DELEGATE.nav setScreenMode:@"home"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    if ([userdefaults objectForKey:@"startup"] == nil )
    {
        [userdefaults setObject:@"YES" forKey:@"startup"];
        [userdefaults synchronize];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TutorialViewController *tradeVC = [storyboard instantiateViewControllerWithIdentifier:@"tutorial"];
        [self presentViewController:tradeVC animated:NO completion:^{
        }];
    }
    
    if (self.nMode == 1) {
        [self onTapTakePhoto:nil];
    }else if (self.nMode == 2)
    {
        [self onTapGallery:nil];
        
    }
}

-(IBAction)onTapTakePhoto:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = NO;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(IBAction)onTapGallery:(id)sender
{

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = NO;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:imagePicker animated:YES completion:nil];
 
/*
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* galleryController = [storyboard instantiateViewControllerWithIdentifier:@"GalleryController"];
    APP_DELEGATE.nav = [[NavigationController alloc] initWithRootViewController:galleryController];
    APP_DELEGATE.sideviewController.centerPanel = APP_DELEGATE.nav;
*/
}

-(IBAction)onTapEditing:(id)sender
{
/*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"mainview"];
    APP_DELEGATE.nav = [[NavigationController alloc] initWithRootViewController:mainVC];
    APP_DELEGATE.sideviewController.centerPanel = APP_DELEGATE.nav;
*/
}

-(IBAction)onTapSetting:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TutorialViewController *tradeVC = [storyboard instantiateViewControllerWithIdentifier:@"tutorial"];
    [self presentViewController:tradeVC animated:NO completion:^{}];
}

#pragma mark - Image picker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissViewControllerAnimated:true completion:^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ImageProcessController* controller = (ImageProcessController*) [storyboard instantiateViewControllerWithIdentifier:@"ImageProcessController"];
        NSData* data = UIImageJPEGRepresentation(image, 1.0f);
        controller.m_OriginalImageData = data;
        APP_DELEGATE.nav = [[NavigationController alloc] initWithRootViewController:controller];
        APP_DELEGATE.sideviewController.centerPanel = APP_DELEGATE.nav;
    }];

/*
    [self dismissViewControllerAnimated:YES completion:^{
        TOCropViewController *cropController = [[TOCropViewController alloc] initWithImage:image];
        cropController.delegate = self;
        [self.navigationController pushViewController:cropController animated:YES];
    }];
*/
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Cropper Delegate -
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    [self.navigationController popViewControllerAnimated:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
/*
        UIImage* scaledImage = [image resizedImageToFitInSize:CGSizeMake(1024, 1024) scaleIfSmaller:NO];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"mainview"];
        mainVC.originalImage = scaledImage;
        APP_DELEGATE.nav = [[NavigationController alloc] initWithRootViewController:mainVC];
        APP_DELEGATE.sideviewController.centerPanel = APP_DELEGATE.nav;
*/ 
    });
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
