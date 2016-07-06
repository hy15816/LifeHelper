//
//  IndexCollectionViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "IndexCollectionViewController.h"
#import "IndexCollectionCell.h"
#import "HttpRequestObj.h"
#import "TuringViewController.h"
#import "TestViewController.h"
#import "ShakeViewController.h"
#import "ChartLineViewController.h"
#import "LockViewController.h"

@interface IndexCollectionViewController ()

@property (strong, nonatomic) IBOutlet UIButton *rightButton;
- (IBAction)rightButtonAction:(UIButton *)sender;
@property (strong, nonatomic) NSMutableArray *itemsList;

@property (strong,nonatomic) NSTimer *indexTimer;
@property (assign,nonatomic) int index;
@end

@implementation IndexCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerClass:[IndexCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    
//    [self performSelector:@selector(startIndexTimer) withObject:nil afterDelay:10];
//    if ([self respondsToSelector:@selector(runabc:)]) {
//        id akk =  [self performSelector:@selector(runabc:) withObject:@"abc"];
//        NNLog(@"akk:%@",akk);
//    }
    
}

//- (void)runabc:(id)obj {
//    
//    NNLog(@"obj:%@",obj);
//}

- (void)startIndexTimer {
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(indexTimerChanged) userInfo:nil repeats:YES];
    self.indexTimer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)indexTimerChanged {
    self.index ++;
    NNLog(@"self.index:%d",self.index);
    
    if (self.index == 10) {
        NSString *str = @"itms-services://?action=download-manifest&url=https://admin.430569.com/anerfaios/anerfa_test.plist";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
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

    return self.itemsList.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    IndexCollectionCell *cell = (IndexCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.collectionModel = self.itemsList[indexPath.row];
    
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((DEVICE_WIDTH - 40)/4, (DEVICE_WIDTH - 40)/4);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark -- UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *itemId = [self.itemsList[indexPath.row] itemID];
    NNLog(@"itemId:%@",itemId);
    UIViewController *controller = nil;
    switch ([itemId integerValue]) {
        case 0:
            //phone address
            controller = kStoryboardIndex(@"PhoneAttributionVC");
            break;
        case 1:
            //turing
            controller = kStoryboardIndex(@"TuringViewController");//kStoryboardIndex(@"PhoneAttributionVC");
            break;
        case 2:
            //话费充值
            controller = kStoryboardIndex(@"RechargeCollectionViewController");
            break;
        case 3:
            //天气查询
            controller = kStoryboardIndex(@"WeatherViewController");
            break;
        case 5:
            //折线图
            controller = [[ChartLineViewController alloc] init];
            break;
        case 6:
            // 照片
            controller = kStoryboardIndex(@"PhotoTableViewController");
            break;
        case 7:
            // wifi
            controller = kStoryboardIndex(@"WiFiViewController");
            break;
        case 8:
            // food
            controller = kStoryboardFoods(@"FoodsTableViewController");
            break;
        case 9:
            // shares
            controller = kStoryboardShares(@"SharesTableViewController");
            break;
        case 10:
            // shares
            controller = kStoryboardShares(@"SharesTableViewController");
            break;
        case 11:
            // shares
            controller = [[LockViewController alloc] init];
            break;
        default:
            controller = [[ShakeViewController alloc] init];
            break;
    }
    
    
    if (controller) {
        [self.navigationController pushViewController:controller animated:YES];
    }else {
        NNLog(@"pushViewController: controller == nil");
    }
    
    
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (IBAction)rightButtonAction:(UIButton *)sender {
    
    UIViewController *settings = kStoryboardIndex(@"SettingsTableViewController");
    [self.navigationController pushViewController:settings animated:YES];
}

- (NSMutableArray *)itemsList {
    if (!_itemsList) {
        _itemsList = [[NSMutableArray alloc] init];
    }
    NSArray *names = @[@"phone",@"Turing",@"recharge",@"weather",@"device",@"draw",@"photo",@"WiFi",@"Foods",@"shares",@"test",@"0.0",@"..."];
    for (int i=0; i<names.count; i++) {
        NSDictionary *dic = @{@"id":[NSString stringWithFormat:@"%d",i],
                              @"name":names[i],
                              @"image":[NSString stringWithFormat:@"%d",i]
                              };
        IndexCollectionModel *model = [IndexCollectionModel modelWithDic:dic];
        [_itemsList addObject:model];
    }
    
    return _itemsList;
}



















@end
