//
//  IndexCollectionCell.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexCollectionModel.h"

@interface IndexCollectionCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (strong,nonatomic) IndexCollectionModel *collectionModel;

@end
