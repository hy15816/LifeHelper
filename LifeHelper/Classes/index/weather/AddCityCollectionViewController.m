//
//  AddCityCollectionViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/22.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "AddCityCollectionViewController.h"
#import "AddCityCollectionViewCell.h"
#import "AddCityCollectionHeaderView.h"

@interface AddCityCollectionViewController ()
{
    NSMutableArray *_hostCityListArray;
}
@end

@implementation AddCityCollectionViewController

static NSString * const reuseIdentifier_cell = @"Cell_id";
static NSString * const reuseIdentifier_header = @"header_id";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    _hostCityListArray = [[NSMutableArray alloc] init];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerClass:[AddCityCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier_cell];
    [self.collectionView registerClass:[AddCityCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier_header];
    
    // Do any additional setup after loading the view.
    
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;//_hostCityListArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AddCityCollectionViewCell *cell = (AddCityCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier_cell forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    cell.layer.borderWidth = 0.5f;
    cell.layer.masksToBounds = YES;
    cell.cityNameLabel.text = @"xdsadas";
    // Configure the cell
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((DEVICE_WIDTH - 0.03)/3.f, 50);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0.01, 0, 0.01);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.001f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.001f;
}
// 添加头视图
// 1.实现方法 [collectionView:viewForSupplementaryElementOfKind:atIndexPath]
// 2.实现方法 [collectionView:layout:referenceSizeForHeaderInSection:]
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        //
        AddCityCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:reuseIdentifier_header forIndexPath:indexPath];
        
        if (indexPath.section == 0) {
            reusableView = headerView;
        }
        
    }
    
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(DEVICE_WIDTH, 100);
}

#pragma mark - <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AddCityCollectionViewCell *cell = (AddCityCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
@end
