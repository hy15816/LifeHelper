//
//  LSScrollItemView.m
//  LifeHelper
//
//  Created by Lost_souls on 16/6/21.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "LSScrollItemView.h"

@interface LSScrollItemView ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UILabel *_bottomLineLabel;
}
@property (strong,nonatomic) UIView *backgroundView;
@property (strong,nonatomic) NSArray *btnsList;
@property (strong,nonatomic) UICollectionView *collectionView;

@property (strong,nonatomic) didSelectBtnBlock myBlock;
@end

static NSString *collectionCellIdentifier = @"LSItemCell";

@implementation LSScrollItemView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles block:(didSelectBtnBlock)block{
    
    if (self = [super initWithFrame:frame]) {
        
        self.btnsList = titles;
        if (block) {
            self.myBlock = block;
        }
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.backgroundView.backgroundColor = [UIColor purpleColor];
    [self.backgroundView addSubview:self.collectionView];
    
    
    CGFloat lineW = self.frame.size.width/4 -10*2-5;
    _bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height-2, lineW, 2)];
    _bottomLineLabel.backgroundColor = [UIColor greenColor];
    
    [self.backgroundView addSubview:_bottomLineLabel];
    [self.backgroundView bringSubviewToFront:_bottomLineLabel];
    [self addSubview:self.backgroundView];
    
}




#pragma mark - CollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.btnsList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LSItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = kCOLORRANDOM;
    cell.label.text = self.btnsList[indexPath.row];
    if (indexPath.row == self.btnsList.count -1) {
        cell.splitLine.hidden = YES;
    }
    NNLog(@"cell.w:%f",cell.frame.size.width);
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(90, self.frame.size.height);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.myBlock) {
        self.myBlock(self,indexPath.row);
    }
}


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.minimumLineSpacing = 0;
//        layout.minimumInteritemSpacing = 0;
//        layout.itemSize = CGSizeMake(self.frame.size.width/4, self.frame.size.height);
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[LSItemCell class] forCellWithReuseIdentifier:collectionCellIdentifier];
        _collectionView.backgroundColor = [UIColor redColor];
    }
    return _collectionView;
}

@end


@implementation LSItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {

        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0.5, 0, self.frame.size.width -1, self.frame.size.height)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:16.f];
        self.label.textColor = [UIColor redColor];
        
        self.splitLine = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 0.5, 15, 1, self.frame.size.height - 15*2)];
        self.splitLine.backgroundColor = [UIColor blueColor];
        [self addSubview:self.label];
        [self addSubview:self.splitLine];
    }
    return self;
}



@end
