//
//  PhotoTableViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/31.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "PhotoTableViewController.h"
#import <PhotosUI/PhotosUI.h>

@interface PhotoTableViewController ()<PHPhotoLibraryChangeObserver>

@property (strong,nonatomic) NSArray *sectionDatasources;
@property (strong,nonatomic) NSArray *sectionTitles;

@end

@implementation PhotoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    if ([PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusAuthorized) {
        NNLog(@"...........未获取授权");
        
        NotFoundView *notFound = [[NotFoundView alloc] init] ;
        [notFound createViewWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) msg:@"您还未授权" block:^{
            //
            NNLog(@"  click");
        }];
        
        return;
    }
    
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    
    // 获取所有照片
    PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    
    // 智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    self.sectionTitles = @[@"", @"Smart Albums",@"Albums"];
    self.sectionDatasources = @[allPhotos,smartAlbums,topLevelUserCollections];
    
    // 监听相册change 通知
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PHPhotoLibraryChangeObserver
- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sectionDatasources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger num = 0;
    if(section == 0 ){
        num = 1;
    }else {
        
        PHFetchResult *fetchResult = self.sectionDatasources[section];
        num = fetchResult.count;
    };
    
    return num;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
        cell.textLabel.text = @"所有照片";
    }else {
        
        PHFetchResult *fetchResult = self.sectionDatasources[indexPath.section];
        PHCollection *collection = fetchResult[indexPath.row];
        
        NNLog(@"collection.localizedTitle:%@",collection.localizedTitle);
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
        cell.textLabel.text = collection.localizedTitle;
        
    }
    
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
