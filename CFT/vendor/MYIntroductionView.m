//
//  MYIntroductionView.m
//  IntroductionExample
//
//  Copyright (C) 2013, Matt York
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "MYIntroductionView.h"
#import "AppConstant.h"
#define DEFAULT_BACKGROUND_COLOR [UIColor colorWithWhite:0 alpha:0.9]
#define HEADER_VIEW_HEIGHT 50
#define PAGE_CONTROL_PADDING 2
#define TITLE_FONT [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0]
#define TITLE_TEXT_COLOR [UIColor whiteColor]
#define DESCRIPTION_FONT [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0]
#define DESCRIPTION_TEXT_COLOR [UIColor whiteColor]

@implementation MYIntroductionView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeClassVariables];
        [self buildUIWithFrame:frame headerViewVisible:YES];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame headerText:(NSString *)headerText panels:(NSArray *)panels
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeClassVariables];
        Panels = [panels copy];
        LanguageDirection = MYLanguageDirectionLeftToRight;
        [self buildUIWithFrame:frame headerViewVisible:YES];
        [self setHeaderText:headerText];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame headerImage:(UIImage *)headerImage panels:(NSArray *)panels
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeClassVariables];
        Panels = [panels copy];
        LanguageDirection = MYLanguageDirectionLeftToRight;
        [self buildUIWithFrame:frame headerViewVisible:YES];
        [self setHeaderImage:headerImage];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame headerText:(NSString *)headerText panels:(NSArray *)panels languageDirection:(MYLanguageDirection)languageDirection
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeClassVariables];
        Panels = [panels copy];
        LanguageDirection = languageDirection;
        [self buildUIWithFrame:frame headerViewVisible:YES];
        [self setHeaderText:headerText];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame headerImage:(UIImage *)headerImage panels:(NSArray *)panels languageDirection:(MYLanguageDirection)languageDirection
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeClassVariables];
        Panels = [panels copy];
        LanguageDirection = languageDirection;
        [self buildUIWithFrame:frame headerViewVisible:YES];
        [self setHeaderImage:headerImage];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame panels:(NSArray *)panels
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeClassVariables];
        Panels = [panels copy];
        LanguageDirection = MYLanguageDirectionLeftToRight;
        [self buildUIWithFrame:frame headerViewVisible:NO];
        [self setHeaderText:nil];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame panels:(NSArray *)panels languageDirection:(MYLanguageDirection)languageDirection
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeClassVariables];
        Panels = [panels copy];
        LanguageDirection = languageDirection;
        [self buildUIWithFrame:frame headerViewVisible:NO];
        [self setHeaderText:nil];
    }
    return self;
}


-(void)initializeClassVariables{
    panelViews = [[NSMutableArray alloc] init];
}

#pragma mark - UI Builder Methods

-(void)buildUIWithFrame:(CGRect)frame headerViewVisible:(BOOL)headerViewVisible{
    self.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    [self buildBackgroundImage];
    [self buildHeaderViewWithFrame:frame visible:headerViewVisible];
    [self buildContentScrollViewWithFrame:frame];
    [self buildFooterView];
}

-(void)buildBackgroundImage{
    self.BackgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];
    self.BackgroundImageView.backgroundColor = [UIColor clearColor];
    self.BackgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.BackgroundImageView.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.BackgroundImageView];
}

-(void)buildHeaderViewWithFrame:(CGRect)frame visible:(BOOL)visible{
    if (!visible) {
        self.HeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        return;
    }
    
    self.HeaderView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width - 10, HEADER_VIEW_HEIGHT)]; //Leave 5px padding on all sides
    self.HeaderView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    self.HeaderView.backgroundColor = [UIColor clearColor];
    
    //Setup HeaderImageView
    self.HeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.HeaderView.frame.size.width, self.HeaderView.frame.size.height)];
    self.HeaderImageView.backgroundColor = [UIColor clearColor];
    self.HeaderImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.HeaderView addSubview:self.HeaderImageView];
    self.HeaderImageView.hidden = YES;
    
   
    [self addSubview:self.HeaderView];
}

-(void)buildContentScrollViewWithFrame:(CGRect)frame{

    self.ContentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.HeaderView.frame.origin.y + self.HeaderView.frame.size.height + 10, frame.size.width, 0)];
    self.ContentScrollView.pagingEnabled = YES;
    self.ContentScrollView.showsHorizontalScrollIndicator = NO;
    self.ContentScrollView.showsVerticalScrollIndicator = NO;
    self.ContentScrollView.delegate = self;
    self.ContentScrollView.userInteractionEnabled = YES;
    self.ContentScrollView.exclusiveTouch = YES;
    self.ContentScrollView.panGestureRecognizer.delaysTouchesBegan = self.ContentScrollView.delaysContentTouches;
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickNextButton:)];
    [self.ContentScrollView addGestureRecognizer:singleTap];
    

    
    //If panels exist, build views for them and add them to the ContentScrollView
    if (Panels) {
        if (Panels.count > 0) {
            
         
            
            
            [self buildContentScrollViewLeftToRight];
            
                
        }
    }
}

-(void)buildContentScrollViewLeftToRight{
    //A running x-coordinate. This grows for every page
    CGFloat contentXIndex = 0;
    for (int ii = 0; ii < Panels.count; ii++) {
        
        //Create a new view for the panel and add it to the array
        [panelViews addObject:[self PanelViewForPanel:Panels[ii] atXIndex:&contentXIndex]];
        
        //Add the newly created panel view to ContentScrollView
        [self.ContentScrollView addSubview:panelViews[ii]];
    }
    
    
    
    //Dynamically sizes the content to fit the text content
    [self setContentScrollViewHeightForPanelIndex:0 animated:NO];
    
    //Add a view at the end. This is simply "something to scroll toward" on the final panel.
    [self appendCloseViewAtXIndex:&contentXIndex];
    
    //Finally, resize the content size of the scrollview to account for all the new views added to it
    self.ContentScrollView.contentSize = CGSizeMake(contentXIndex, self.ContentScrollView.frame.size.height);
    
    //Add the ContentScrollView to the introduction view
    [self addSubview:self.ContentScrollView];
}

-(UIView *)PanelViewForPanel:(MYIntroductionPanel *)panel atXIndex:(CGFloat*)xIndex{
    
    //Build panel now that we have all the desired dimensions
    UIView *panelView = [[UIView alloc] initWithFrame:CGRectMake(*xIndex, 0, self.ContentScrollView.frame.size.width, 0)];
    
    
    CGFloat imageWidth = panel.Image.size.width*SCREENWIDTH/320;
    CGFloat imageHeight = panel.Image.size.height*SCREENHEIGHT/568;
    
    
    
    panelView.frame = CGRectMake(*xIndex, 0, self.ContentScrollView.frame.size.width, self.ContentScrollView.frame.size.height);
    
    //Build image container
    UIImageView *panelImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-imageWidth)/2, 0, imageWidth, imageHeight)];
    panelImageView.contentMode = UIViewContentModeScaleAspectFit;
    panelImageView.backgroundColor = [UIColor clearColor];
    panelImageView.image = panel.Image;
    panelImageView.layer.cornerRadius = 3;
    panelImageView.clipsToBounds = YES;
    [panelView addSubview:panelImageView];
    
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT- 230, SCREEN_WIDTH, 230)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [panelView addSubview:bottomView];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, SCREEN_WIDTH-40, 21)];

    switch ((int)(*xIndex/self.ContentScrollView.frame.size.width)) {
        case 0:
        {
            titleLabel.text = @"Main Menu";
            break;
        }
        case 1:
        {
            titleLabel.text = @"Preparing for editing";
            break;
        }
        case 2:
        {
            titleLabel.text = @"Face Identified";
            break;
        }
        case 3:
        {
            titleLabel.text = @"Face Editing";
            break;
        }
        case 4:
        {
            titleLabel.text = @"Success";
            break;
        }
        default:
            break;
    }
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    [bottomView addSubview:titleLabel];
    
    UILabel * descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 8+21, SCREEN_WIDTH-40, 150)];
    
    switch ((int)(*xIndex/self.ContentScrollView.frame.size.width)) {
        case 0:
        {
            descriptionLabel.text = @"In the main menu are four shortcuts of this application which can perform certain functions (take a new picture, Editing a photo gallery, go back to your last edition, back to the tutorial), this will allow you to quickly access the option of your choice.";
            break;
        }
        case 1:
        {
            descriptionLabel.text = @"After choosing between taking a new photo or use one of our gallery, we focus on the pre-edition Celebrity Trade Face process, in this process we can choose the size of the photo and faces want to scan and then exchange them for the celebrity.";
            break;
        }
        case 2:
        {
            descriptionLabel.text = @"In this section you can choose the mode to change the face, you can select between searching by ourselves or accept suggestions Celebrity Trade Face, the main thing is to choose the face that you want to change (the active face is shown in a frame blue), you can select by clicking on the face or directly use the white arrows.";
            break;
        }
        case 3:
        {
            descriptionLabel.text = @"After selecting face, you can change the skintone add/delete/resize/rotate. The active face will be changed. This feature will be helpful for matching face to origenal photo.";
            break;
        }
        case 4:
        {
            descriptionLabel.text = @"Thanks for traning celebrity face. You can purchase for removing border. Just save photo to device and sharing to social app";
            break;
        }
        default:
            break;
    }
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    descriptionLabel.numberOfLines = 0;
    [descriptionLabel setFont:[UIFont systemFontOfSize:11]];
    [bottomView addSubview:descriptionLabel];
    [descriptionLabel sizeToFit];
    
//    UIButton* nextButton = [[UIButton alloc] initWithFrame:panel.nextRect];
//    [nextButton addTarget:self action:@selector(onClickNextButton:) forControlEvents:UIControlEventTouchUpInside];
//    [nextButton setBackgroundColor:[UIColor whiteColor]];
//    [panelView addSubview:nextButton];
    
    
    
    //Update xIndex
    *xIndex += self.ContentScrollView.frame.size.width;
    
    return panelView;
}

-(void)appendCloseViewAtXIndex:(CGFloat*)xIndex{
    UIView *closeView = [[UIView alloc] initWithFrame:CGRectMake(*xIndex, 0, self.frame.size.width, 400)];
    
    [self.ContentScrollView addSubview:closeView];
    
     *xIndex += self.ContentScrollView.frame.size.width;
}

-(void)buildFooterView{
    //Build Page Control
    float scale_x = 1;
    float scale_y = 1;

    if (IS_IPHONE_4_OR_LESS) {
        self.PageControl1 = [[FXPageControl alloc] initWithFrame:CGRectMake((self.frame.size.width - 185)/2,self.frame.size.height-26, 185, 26)];
    }else
        self.PageControl1 = [[FXPageControl alloc] initWithFrame:CGRectMake((self.frame.size.width - 185)/2,self.frame.size.height-46, 185, 36)];
   
    [self.PageControl1 setDotSize:13];
    [self.PageControl1 setDotColor:[UIColor colorWithRed:179.0/255.0 green:226.0/255.0 blue:236.0/255.0 alpha:1.0]];
    [self.PageControl1 setSelectedDotColor:[UIColor colorWithRed:7.0/255.0 green:204.0/255.0 blue:241.0/255.0 alpha:1.0]];
    [self.PageControl1 setBackgroundColor:[UIColor clearColor]];
    self.PageControl1.numberOfPages = Panels.count;
    [self addSubview:self.PageControl1];

    
    
    
}

-(void)setContentScrollViewHeightForPanelIndex:(NSInteger)panelIndex animated:(BOOL)animated{
    CGFloat newPanelHeight = [self frame].size.height;
   
    
    self.ContentScrollView.frame = CGRectMake(self.ContentScrollView.frame.origin.x, self.ContentScrollView.frame.origin.y, self.ContentScrollView.frame.size.width, newPanelHeight);
    
    self.PageControl1.frame = CGRectMake(self.PageControl1.frame.origin.x, (self.ContentScrollView.frame.origin.y + self.ContentScrollView.frame.size.height + PAGE_CONTROL_PADDING), self.PageControl1.frame.size.width, self.PageControl1.frame.size.height);
  
    
    self.ContentScrollView.contentSize = CGSizeMake(self.ContentScrollView.contentSize.width, newPanelHeight);
}

#pragma mark - Header Content

-(void)setHeaderText:(NSString *)headerText{
    
    self.HeaderImageView.hidden = YES;
  
}

-(void)setHeaderImage:(UIImage *)headerImage {
    
    self.HeaderImageView.hidden = NO;
    self.HeaderImageView.image = headerImage;
}

#pragma mark - Introduction Content

-(void)setBackgroundImage:(UIImage *)backgroundImage{
    self.BackgroundImageView.image = backgroundImage;
}

#pragma mark - Show/Hide

-(void)showInView:(UIView *)view{
    //Add introduction view
    self.alpha = 1;
    [view addSubview:self];
    
    //Fade in
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}

-(void)hideWithFadeOutDuration:(CGFloat)duration{
    //Fade out
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    } completion:nil];
}


-(void)skipIntroduction{
    if ([(id)delegate respondsToSelector:@selector(introductionDidFinishWithType:)]) {
        [delegate introductionDidFinishWithType:MYFinishTypeSkipButton];
    }
    
    [self hideWithFadeOutDuration:0.3];
}

#pragma mark - UIScrollView Delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (LanguageDirection == MYLanguageDirectionLeftToRight) {
        self.CurrentPanelIndex = scrollView.contentOffset.x/self.ContentScrollView.frame.size.width;
        
        //remove self if you are at the end of the introduction
        if (self.CurrentPanelIndex >= (panelViews.count)) {
            if ([(id)delegate respondsToSelector:@selector(introductionDidFinishWithType:)]) {
                [delegate introductionDidFinishWithType:MYFinishTypeSwipeOut];
            }
            [self hideWithFadeOutDuration:0.3];
        }
        else {
            //Update Page Control
            LastPanelIndex = self.PageControl1.currentPage;
            self.PageControl1.currentPage = self.CurrentPanelIndex;
            

            
            //Call Back, if applicable
            if (LastPanelIndex != self.CurrentPanelIndex) { //Keeps from making the callback when just bouncing and not actually changing pages
                if ([(id)delegate respondsToSelector:@selector(introductionDidChangeToPanel:withIndex:)]) {
                    [delegate introductionDidChangeToPanel:Panels[self.CurrentPanelIndex] withIndex:self.CurrentPanelIndex];
                }
            }
        }
    }
  
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (LanguageDirection == MYLanguageDirectionLeftToRight) {
        if (self.CurrentPanelIndex == (panelViews.count - 1)) {
            self.alpha = ((self.ContentScrollView.frame.size.width*panelViews.count)-self.ContentScrollView.contentOffset.x)/self.ContentScrollView.frame.size.width;
        }
    }
    else if (LanguageDirection == MYLanguageDirectionRightToLeft){
        if (self.CurrentPanelIndex == 0) {
            self.alpha = self.ContentScrollView.contentOffset.x/self.ContentScrollView.frame.size.width;
        }
    }
}

-(void)onClickNextButton:(UITapGestureRecognizer*) gesture
{
    CGPoint touchPoint = [gesture locationInView:self.ContentScrollView];
    
    
    MYIntroductionPanel * panel = [Panels objectAtIndex:self.CurrentPanelIndex];
    if (!CGRectContainsPoint(panel.nextRect, touchPoint)) {
        return;
    }
    CGRect frame = self.ContentScrollView.frame;
    self.CurrentPanelIndex++;
    
    if (self.CurrentPanelIndex >= (panelViews.count)) {
        if ([(id)delegate respondsToSelector:@selector(introductionDidFinishWithType:)]) {
            [delegate introductionDidFinishWithType:MYFinishTypeSwipeOut];
        }
        [self hideWithFadeOutDuration:0.3];
    }
    else {
        
        frame.origin.x = frame.size.width * self.CurrentPanelIndex;
        frame.origin.y = 0;
        [self.ContentScrollView scrollRectToVisible:frame animated:YES];
        
        //Update Page Control
        LastPanelIndex = self.PageControl1.currentPage;
        self.PageControl1.currentPage = self.CurrentPanelIndex;
        
        
        
        //Call Back, if applicable
        if (LastPanelIndex != self.CurrentPanelIndex) { //Keeps from making the callback when just bouncing and not actually changing pages
            if ([(id)delegate respondsToSelector:@selector(introductionDidChangeToPanel:withIndex:)]) {
                [delegate introductionDidChangeToPanel:Panels[self.CurrentPanelIndex] withIndex:self.CurrentPanelIndex];
            }
        }
    }
    
    
}

@end
