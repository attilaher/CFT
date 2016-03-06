//
//  GalleryController.h
//  CFT
//
//  Created by Must on 3/5/16.
//  Copyright © 2016 Must. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface GalleryController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSMutableArray* imageArray;
}
@property(nonatomic , strong) PHFetchResult *assetsFetchResults;
@property(nonatomic , strong) PHCachingImageManager *imageManager;
@property (weak, nonatomic) IBOutlet UICollectionView *m_CollectionView;

@end
