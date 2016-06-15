//
//  FoodsTableViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/7.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "FoodsTableViewController.h"
#import "FoodCollectionViewCell.h"
#import "LSCollectionViewLayout.h"
#import "FoodListViewController.h"

@interface FoodsTableViewController ()

{
    NSMutableArray *_foodsMenuCategoryArray;
    NSMutableArray *_cellHeightArray;
}

@end

static NSString * const reuseIdentifier = @"FoodCollectionViewCell";


@implementation FoodsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _cellHeightArray = [[NSMutableArray alloc] init];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerClass:[FoodCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    LSCollectionViewLayout *layout = [[LSCollectionViewLayout alloc] init];
    layout.columns = 3;
    layout.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.cellMarginTop = 10;
    layout.cellMarginLeft = 10;
        
    self.collectionView.collectionViewLayout = layout;
    
    _foodsMenuCategoryArray = [[NSMutableArray alloc] init];
    
    [self getCategory];
    
//    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _foodsMenuCategoryArray.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    FoodCollectionViewCell *cell = (FoodCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.foodsCategoryImage.image = [UIImage imageNamed:@"10"];
    cell.foodCatrgoryTitleLabel.text = _foodsMenuCategoryArray[indexPath.row][@"title"];
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    CGFloat height = 50+(arc4random()%160);
//    [_cellHeightArray addObject:[NSString stringWithFormat:@"%f",height]];
//    return CGSizeMake((DEVICE_WIDTH - 20)/3, height);
//}
//
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    
//    
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}

#pragma mark -- UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FoodListViewController *foodList = kStoryboardFoods(@"FoodListViewController");
    foodList.categoryId = _foodsMenuCategoryArray[indexPath.row][@"id"];
    [self.navigationController pushViewController:foodList animated:YES];
    
    //    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)getCategory {
    
    [HttpRequestObj foodsMenuCategoryWithId:@"0" showSVP:YES result:^(NSDictionary *result, NSError *error) {
        //
        /**
         *  {
             cookclass = 0;                             // 菜谱类别，分类。0-10，0为顶级
             description = "\U4fdd\U5065\U517b\U751f";  //描述
             id = 15;                                   // id
             keywords = "\U4fdd\U5065\U517b\U751f";     // 关键字
             name = "\U4fdd\U5065\U517b\U751f";         //名称
             seq = 0;                                   //序列，排序
             title = "\U4fdd\U5065\U517b\U751f";        //标题
         }
         */
        if (!error) {
            NSLog(@"result == %@",result);
            if ([result[@"status"] integerValue]) {
                NSArray *tngou = result[@"tngou"];
                [self saveData:result];
                [_foodsMenuCategoryArray addObjectsFromArray:tngou];
                dispatch_main(^{
                    [self.collectionView reloadData];
                });
            }
            
        }else {
            NSLog(@"error == %@",error);
        }
    }];
    
}

- (void)saveData:(NSDictionary *)tngou {
    
    BOOL save = [GlobalTool localSaveDatasWithDict:tngou name:kFoodsFileName];
    if (!save) {
        NNLog(@"save failed !");
    }
    
    [self getData];
}

- (void)getData {
    
    NSDictionary *list = [GlobalTool localAllDataDict:kFoodsFileName];
    NNLog(@"list:%@",list);
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
