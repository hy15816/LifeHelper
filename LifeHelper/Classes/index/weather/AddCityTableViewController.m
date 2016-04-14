//
//  AddCityTableViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/22.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "AddCityTableViewController.h"
#import "AddCityTableViewCell.h"
#import "MJRefresh.h"

@interface AddCityTableViewController ()<UISearchControllerDelegate,UISearchResultsUpdating>
{
    NSMutableArray *_cityListArray;
    NSMutableArray *_searchCityListArray;
    NSMutableArray *_currentArray;
}

@property (strong, nonatomic) UITableViewController *tableViewController;
@property (strong, nonatomic) UISearchController *searchController;
@end

@implementation AddCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _searchCityListArray = [[NSMutableArray alloc] init];

    [self addItems];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self initSearchController];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //
        sleep(2);
        [self.tableView.mj_header endRefreshing];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    
    NSLog(@"--------%@",self.class);
    NSLog(@"--------%@",self.view.subviews);
    
}

- (void)initSearchController {
    
    self.tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableViewController.tableView.delegate = self;
    self.tableViewController.tableView.dataSource = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.tableViewController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
    self.searchController.searchBar.frame = CGRectMake(0, 64, self.view.frame.size.width, 44.0);
    self.searchController.dimsBackgroundDuringPresentation = YES;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;//输入时显示状态栏，
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.searchController.active) {
        if (_searchCityListArray.count % 3 == 0) {
            return _searchCityListArray.count / 3;
        }
        return _searchCityListArray.count / 3 + 1;
    }else {
        if (_cityListArray.count % 3 == 0) {
            return _cityListArray.count / 3;
        }
        return _cityListArray.count / 3 + 1;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddCityTableViewCell *cell = [AddCityTableViewCell cellWithTableView:tableView];
    
    
    NSInteger leftIndex     = indexPath.row * 3 + 0 ;
    NSInteger centerIndex   = indexPath.row * 3 + 1 ;
    NSInteger rightIndex    = indexPath.row * 3 + 2 ;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];;
    if (self.searchController.active) {
        array = _searchCityListArray;
    }else {
        array = _cityListArray;
    }
    
    cell.leftCityModel = array[leftIndex];
    
    if (centerIndex < array.count) {
        cell.centerCityModel = array[centerIndex];
    }else {
        cell.centerCityModel = nil;
    }

    if (rightIndex < array.count) {

        cell.rightCityModel = array[rightIndex];
    }else {
        cell.rightCityModel = nil;
    }
    
    if (cell.leftNameButton.tag == 9) {
        cell.leftImageView.backgroundColor = [UIColor greenColor];
    }
    cell.buttonTapActionBlock = ^(UIButton *btn){
        NSLog(@"btn.tag:%ld",(long)btn.tag);
        AddCityModel *currentModel = nil;
        for (AddCityModel *model in array) {
            if ([model.cityId integerValue] == btn.tag) {
                currentModel = model;
            }
        }
        [AlertView showMessage:currentModel.cityName time:1];
    };
    
    return cell;
}

#pragma mark - UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController {
    
    NSLog(@"willPresentSearchController");
}
- (void)didPresentSearchController:(UISearchController *)searchController {
    NSLog(@"didPresentSearchController");
}
- (void)willDismissSearchController:(UISearchController *)searchController {
    NSLog(@"willDismissSearchController");
}
- (void)didDismissSearchController:(UISearchController *)searchController {
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController {
    NSLog(@"presentSearchController");
}
#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = [self.searchController.searchBar text];
    NSLog(@"searchString:%@",searchString);
    if (_searchCityListArray.count) {
        [_searchCityListArray removeAllObjects];
    }
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF contains [c]  %@",searchString ];
    for (AddCityModel *model in _cityListArray) {
        if ([preicate evaluateWithObject:model.cityId] ) {
            if (![_searchCityListArray containsObject:model]) {
                [_searchCityListArray addObject:model];
            }
        }
    }
    NSLog(@"_searchCityListArray:%@",_searchCityListArray);
    [self.tableViewController.tableView reloadData];
    [self.tableView reloadData];
}

#pragma mark - ======
- (void)addItems {
    
    _cityListArray = [[NSMutableArray alloc] init];
    for (int i=0; i<100; i++) {
        NSInteger isCheck = arc4random()%100;
        if (isCheck == 10) {
            isCheck = 1;
        }else{
            isCheck = 0;
        }
        NSDictionary *dic = @{@"cityId":[NSString stringWithFormat:@"%d",i],
                              @"cityName":[NSString stringWithFormat:@"city %d",i],
                              @"imageName":[NSString stringWithFormat:@"imageName_%d",i],
                              @"isCheck":[NSString stringWithFormat:@"%ld",(long)isCheck]};
        AddCityModel *model = [AddCityModel modelWithDict:dic];
        [_cityListArray addObject:model];
    }
    
}

@end
