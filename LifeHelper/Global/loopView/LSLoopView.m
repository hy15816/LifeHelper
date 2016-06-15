//
//  LSLoopViews.m
//  ActionSheet
//
//  Created by AEF-RD-1 on 15/10/23.
//  Copyright (c) 2015年 hyIm. All rights reserved.
//

#define kPageControlH   20
#define kLabelHeight    20
#define kLabelMarginLeft    10
#define kDefaultTimeInterval 3.f

#import "LSLoopView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+YYAdd.h"

@interface LSLoopView ()<UIScrollViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic) NSMutableArray *loopImages;    //图片
@property (strong,nonatomic) NSMutableArray *loopImagesURL; //图片url
@property (strong,nonatomic) NSMutableArray *loopTitles;    //标题
@property (weak,nonatomic) id<LSLoopViewDelegate> delegate;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIPageControl *pageControl;
@property (strong,nonatomic) NSTimer *scrollTimer;
@property (strong,nonatomic) NSString *placeholderImgName;
@property (strong,nonatomic) didSelectedIndex mBlock;
@property (assign,nonatomic) NSInteger loopPages;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (assign,nonatomic) BOOL collectionViewFlag;

@end

static NSString *collectionCellIdentifier = @"LSLoopViewCell";

@implementation LSLoopView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        _loopTimeInterval = kDefaultTimeInterval;
        _loopScroll = YES;
        _loopHidePageControl = NO;
        self.loopImages = [[NSMutableArray alloc] init];
        self.loopTitles = [[NSMutableArray alloc] init];
        
    }
    return self;
}

#pragma mark - deprecated method
+ (instancetype)loopViewWithFrame:(CGRect)frame delegate:(id<LSLoopViewDelegate>)delegate imagesArray:(NSMutableArray *)images titleArray:(NSMutableArray *)titles{
    LSLoopView *loopView = [[self alloc] initWithFrame:frame];
    if (delegate) {
        loopView.delegate = delegate;
    }

    loopView.loopImages = images;
    loopView.loopTitles = titles;
    loopView.loopPages = images.count;
    [loopView setupView];
    return loopView;
}


+ (instancetype)loopViewWithFrame:(CGRect)frame delegate:(id<LSLoopViewDelegate>)delegate imagesURLArray:(NSMutableArray *)imageURLs titleArray:(NSMutableArray *)titles placeholder:(NSString *)imgName;{
    
    LSLoopView *loopView = [[self alloc] initWithFrame:frame];
    if (delegate) {
        loopView.delegate = delegate;
    }
    loopView.loopImagesURL = imageURLs;
    loopView.loopTitles = titles;
    loopView.placeholderImgName = imgName;
    loopView.loopPages = imageURLs.count;
    [loopView setupView];
    
    return loopView;
}

#pragma mark - New Methods ls_loop
// ==================ls_loop=========
- (instancetype)initWithFrame:(CGRect)frame imagesArray:(NSMutableArray *)images titleArray:(NSMutableArray *)titles selectedBlock:(didSelectedIndex)block{
    
    self = [super initWithFrame:frame];
    if (self) {
        if (block) {
            self.mBlock = block;
        }
        _loopTimeInterval = kDefaultTimeInterval;
        _loopScroll = YES;
        _loopHidePageControl = NO;
        self.loopImages = [[NSMutableArray alloc] initWithArray:images];
        self.loopTitles = [[NSMutableArray alloc] initWithArray:titles];
        
        self.loopPages = images.count;
        [self setupCollectionView];
    }
    
    return self;
}

+ (instancetype)ls_loopViewWithFrame:(CGRect)frame imagesArray:(NSMutableArray *)images titleArray:(NSMutableArray *)titles selectedBlock:(didSelectedIndex)block {
    
    return [[self alloc] initWithFrame:frame imagesArray:images titleArray:titles selectedBlock:block];
}



- (instancetype)initWithFrame:(CGRect)frame imagesURLArray:(NSMutableArray *)imageURLs titleArray:(NSMutableArray *)titles placeholder:(NSString *)imgName selectedBlock:(didSelectedIndex)block{
    
    self = [super initWithFrame:frame];
    if (self) {
        if (block) {
            self.mBlock = block;
        }
        
        _loopTimeInterval = kDefaultTimeInterval;
        _loopScroll = YES;
        _loopHidePageControl = NO;
        self.loopImagesURL = [[NSMutableArray alloc] initWithArray:imageURLs];
        self.loopTitles = [[NSMutableArray alloc] initWithArray:titles];
        self.placeholderImgName = imgName;
        self.loopPages = imageURLs.count;
        [self setupCollectionView];
    }
    
    
    return self;
}

+ (instancetype)ls_loopViewWithFrame:(CGRect)frame imagesURLArray:(NSMutableArray *)imageURLs titleArray:(NSMutableArray *)titles placeholder:(NSString *)imgName selectedBlock:(didSelectedIndex)block{
    return [[self alloc] initWithFrame:frame imagesURLArray:imageURLs titleArray:titles placeholder:imgName selectedBlock:block];
}


#pragma mark - Setup UI
/**
 *  使用CollectionView布局
 */
- (void)setupCollectionView {
    
    self.collectionViewFlag = YES;
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    [self setupTimer];
    
}




/**
 *  使用scrollView
 */
- (void)setupView{
    
    CGFloat wid = self.frame.size.width;
    CGFloat hig = self.frame.size.height;
//    NSInteger views = self.loopImagesURL.count? self.loopImagesURL.count: self.loopImages.count;
    
    //添加图片和标题
    for (int i=0; i<self.loopPages; i++) {
        //imgv tap
        UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchDownInimage)];
        //imgv
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(wid*i, 0, wid, hig)];
        imageview.userInteractionEnabled = YES;
        if (self.loopImagesURL.count) {
            
            [imageview sd_setImageWithURL:self.loopImagesURL[i] placeholderImage:[UIImage imageNamed:self.placeholderImgName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //
                imageview.image = [image imageByResizeToSize:CGSizeMake(self.frame.size.width, self.frame.size.height) contentMode:UIViewContentModeScaleAspectFit];//[self imageCompressForSize:image targetSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
            }];
            /**
             *  UIViewContentModeScaleToFill            //铺满(会压缩或拉伸)
             *  UIViewContentModeScaleAspectFit         //原图大小
             *  UIViewContentModeScaleAspectFill        //铺满view(比例)
             *  UIViewContentModeRedraw                 //铺满(会压缩或拉伸)
             *  UIViewContentModeCenter                 //原图大小
             */
        }else {
            [imageview setImage:[UIImage imageNamed:self.loopImages[i]]];
        }
        
        //label view
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, hig - kLabelHeight, imageview.frame.size.width, kLabelHeight)];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kLabelMarginLeft, hig -kLabelHeight, imageview.frame.size.width-wid/4, kLabelHeight)];
        
        label.textColor =[UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:16];
        if (self.loopTitles.count) {
            label.text = self.loopTitles[i];
        }
        
        [imageview addSubview:view];
        [imageview addSubview:label];
        [imageview addGestureRecognizer:tapGR];
        
        [self.scrollView addSubview:imageview];
    }
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self setupTimer];
}



/**
 *  创建(重启)定时器
 */
- (void)setupTimer{
    
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_loopTimeInterval target:self selector:@selector(autoScrollAction) userInfo:nil repeats:YES];
    self.scrollTimer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  定时器方法
 */
- (void)autoScrollAction{
    
    //NSLog(@"timer did running...");
    //NSInteger count = self.loopImagesURL.count ? self.loopImagesURL.count : self.loopImages.count;
    
    if (self.loopPages == 0) {
        return;
    }
    UIScrollView *scroll = self.scrollView;
    if (self.collectionViewFlag) {
        scroll = (UIScrollView *)self.collectionView;
    }
    int currentIndex = fabs(scroll.contentOffset.x)/scroll.frame.size.width;
    
    int targetIndex = currentIndex + 1;
    if (targetIndex == self.loopPages) {// if最后一张,回到第一张
        targetIndex = 0;
        if (self.collectionViewFlag) {
            //
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        }else {
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        
    }
    
    //滚动至下一个
    if (self.collectionViewFlag) {
        //
        NSIndexPath *path = [NSIndexPath indexPathForRow:targetIndex inSection:0];
        [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        
    }else{
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * targetIndex, 0) animated:YES];
    }
    
}

/**
 *  点击了图片
 */
- (void)touchDownInimage
{
    //
    if ([self.delegate respondsToSelector:@selector(loopView:didSelectItem:)]) {
        [self.delegate loopView:self didSelectItem:self.pageControl.currentPage];
    }
    
}

-(void)CurPageChangeds:(UIPageControl *)pageCtrol{
    //点击小点，显示相应的view(图片)
}

#pragma mark - CollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.loopPages;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LSLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath];
    if (self.loopImagesURL.count) {
        NSString *url = self.loopImagesURL[indexPath.row];
        if ([url isEqual:[NSNull null]] || url == nil) {
            url = @"";
        }
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:self.placeholderImgName] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //
            cell.imageView.image = [self imageCompressForSize:image targetSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        }];
        
    }else{
        cell.imageView.image = [UIImage imageNamed:self.loopImages[indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mBlock) {
        self.mBlock(self,indexPath.row);
    }
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.collectionViewFlag) {
        //
//        self.collectionView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
        //滚动图片，改变小点的显示位置
        int index = fabs(self.collectionView.contentOffset.x) / self.collectionView.frame.size.width;
        self.pageControl.currentPage = index;
    }else {
        //设定y为0
        self.scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
        //滚动图片，改变小点的显示位置
        int index = fabs(self.scrollView.contentOffset.x) / self.scrollView.frame.size.width;
        self.pageControl.currentPage = index;
    }
    
}

//在拖动过程中停止定时器，
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [_scrollTimer invalidate];
    _scrollTimer = nil;
}
//拖动结束启动定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_loopScroll == NO) {
        return;
    }
    [self setupTimer];
}

#pragma mark - Setters && getters
/**
 *  设置滚动时间间隔
 *
 *  @param loopTimeInterval 时长
 */
- (void)setLoopTimeInterval:(CGFloat)loopTimeInterval{
    if (!loopTimeInterval) {
        loopTimeInterval = kDefaultTimeInterval;
    }
    _loopTimeInterval = loopTimeInterval;
    if (_loopScroll == NO) {
        return;
    }
    [self setupTimer];
}

-(void)setLoopScroll:(BOOL)loopScroll{
    _loopScroll = loopScroll;
    if (loopScroll == NO) {
        [self.scrollTimer invalidate];
        self.scrollTimer = nil;
    }
}

- (void)setLoopHidePageControl:(BOOL)loopHidePageControl {
    _loopHidePageControl = loopHidePageControl;
    if (loopHidePageControl == YES) {
        self.pageControl.hidden = YES;
    }else{
        self.pageControl.hidden = NO;
    }
}


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = self.frame.size;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[LSLoopViewCell class] forCellWithReuseIdentifier:collectionCellIdentifier];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}


- (UIPageControl *)pageControl{
    
    if (!_pageControl) {
        
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width /2,self.frame.size.height - kPageControlH ,20, kPageControlH)];//居中显示
        if (self.loopTitles.count > 0) {
            _pageControl.frame = CGRectMake(self.frame.size.width /2,self.frame.size.height -kPageControlH ,20, kPageControlH);
        }
        
        _pageControl.numberOfPages = self.loopPages;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(CurPageChangeds:) forControlEvents:UIControlEventValueChanged];

    }
    
    return _pageControl;
}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        [_scrollView setContentSize:CGSizeMake(self.frame.size.width * self.loopPages, 0)];
        [_scrollView setPagingEnabled:YES];  //视图整页显示
        [_scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
        _scrollView.pagingEnabled = YES;//分页效果
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    
    return _scrollView;
}


/**
 *  截取图片指定大小并比例缩小
 *
 *  @param sourceImage <#sourceImage description#>
 *  @param size        <#size description#>
 *
 *  @return <#return value description#>
 */
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

#pragma mark -  willMoveToSuperview

//若退出父view，停止定时器
- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [self.scrollTimer invalidate];
        self.scrollTimer = nil;
    }
}

@end



@implementation LSLoopViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
    }
    return self;
}




@end





