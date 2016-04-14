//
//  YIMKeyboardView.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/19.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#define kItemHeight     60.f

#import "YIMKeyboardView.h"
#import "KeyboardCollectionViewCell.h"

@interface YIMKeyboardView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong ,nonatomic) UICollectionView *collectionViews;
@property (strong ,nonatomic) NSMutableArray *datasourceArray;
@end

static NSString *keyboardCellIndetifier = @"keyboardCellIndetifier";

@implementation YIMKeyboardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self initdefaults];
    }
    
    return self;
}

- (void)initdefaults {
    
    self.userInteractionEnabled = YES;
    [self toolbarView];
    self.collectionViews.backgroundColor = [UIColor whiteColor];
    [self.collectionViews registerClass:[KeyboardCollectionViewCell class] forCellWithReuseIdentifier:keyboardCellIndetifier];
    [self addSubview:self.collectionViews];
    
}

- (void)toolbarView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor greenColor];
    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(downButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(self.frame.size.width - 60, 0, 60, 30);
    [view addSubview:button];
    
    [self addSubview:view];
}

- (void)downButtonAction:(UIButton *)btn {
    
    if (self.downButtonActionBlock) {
        self.downButtonActionBlock(btn);
    }
    
}
#pragma mark - 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.datasourceArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KeyboardCollectionViewCell *cell = (KeyboardCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:keyboardCellIndetifier forIndexPath:indexPath];
    cell.layer.borderWidth = .5f;
    cell.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    cell.keyboardNumberLabel.text = self.datasourceArray[indexPath.row][@"num"];
    cell.keyboardCharacterLabel.text = self.datasourceArray[indexPath.row][@"chc"];
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake((DEVICE_WIDTH - 3)/3.f, 60);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0.5, 0, 0.5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.001f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.001f;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KeyboardCollectionViewCell *cell = (KeyboardCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:keyboardCellIndetifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}







- (UICollectionView *)collectionViews {
    
    if (_collectionViews == nil) {
        UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        collectionViewFlowLayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
        _collectionViews = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, kItemHeight * 4) collectionViewLayout:collectionViewFlowLayout];
        _collectionViews.dataSource = self;
        _collectionViews.delegate = self;
    }
    
    return _collectionViews;
}

- (NSMutableArray *)datasourceArray {
    
    if (_datasourceArray == nil) {
        _datasourceArray = [[NSMutableArray alloc] init];
        NSArray *numArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"",@"0",@""];
        NSArray *chcArray = @[@"",@"ABC",@"DEF",@"GHI",@"JKL",@"MNO",@"PQRS",@"TUV",@"WXYZ",@"",@"",@""];
        for (int i=0; i<12; i++) {
            [_datasourceArray addObject:@{@"num":numArray[i],@"chc":chcArray[i]}];
        }
    }
    
    return _datasourceArray;
}

@end
