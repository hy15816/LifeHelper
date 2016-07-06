//
//  UIScrollView+PlaceholderView.m
//  LifeHelper
//
//  Created by Lost_souls on 16/7/2.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

static char const * const kEmptyDataSetSource =     "emptyDataSetSource";
static char const * const kEmptyDataSetDelegate =   "emptyDataSetDelegate";
static char const * const kEmptyDataSetView =       "emptyDataSetView";
#define kEmptyImageViewAnimationKey @"com.dzn.emptyDataSet.imageViewAnimation"


#import "UIScrollView+PlaceholderView.h"
#import "LSWeakObjectContainer.h"
#import <objc/runtime.h>
#import "LSPlaceholderView.h"

@interface UIScrollView () <UIGestureRecognizerDelegate>
@property (nonatomic, readonly) LSPlaceholderView *emptyDataSetView;
@end

@implementation UIScrollView (PlaceholderView)

- (id<PlaceholderViewDataSource>)emptyDataSetSource
{
    LSWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetSource);
    return container.weakObject;
}

- (id<PlaceholderViewDelegate>)emptyDataSetDelegate
{
    LSWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetDelegate);
    return container.weakObject;
}

- (BOOL)isEmptyDataSetVisible
{
    UIView *view = objc_getAssociatedObject(self, kEmptyDataSetView);
    return view ? !view.hidden : NO;
}

#pragma mark - Getters (Private)

- (LSPlaceholderView *)emptyDataSetView
{
    LSPlaceholderView *view = objc_getAssociatedObject(self, kEmptyDataSetView);
    
    if (!view)
    {
        view = [LSPlaceholderView new];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        view.hidden = YES;
        
        view.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dzn_didTapContentView:)];
        view.tapGesture.delegate = self;
        [view addGestureRecognizer:view.tapGesture];
        
        [self setEmptyDataSetView:view];
    }
    return view;
}

- (BOOL)dzn_canDisplay
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource conformsToProtocol:@protocol(PlaceholderViewDataSource)]) {
        if ([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]] || [self isKindOfClass:[UIScrollView class]]) {
            return YES;
        }
    }
    
    return NO;
}

- (NSInteger)dzn_itemsCount
{
    NSInteger items = 0;
    
    // UIScollView doesn't respond to 'dataSource' so let's exit
    if (![self respondsToSelector:@selector(dataSource)]) {
        return items;
    }
    
    // UITableView support
    if ([self isKindOfClass:[UITableView class]]) {
        
        UITableView *tableView = (UITableView *)self;
        id <UITableViewDataSource> dataSource = tableView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [dataSource numberOfSectionsInTableView:tableView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource tableView:tableView numberOfRowsInSection:section];
            }
        }
    }
    // UICollectionView support
    else if ([self isKindOfClass:[UICollectionView class]]) {
        
        UICollectionView *collectionView = (UICollectionView *)self;
        id <UICollectionViewDataSource> dataSource = collectionView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
            sections = [dataSource numberOfSectionsInCollectionView:collectionView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource collectionView:collectionView numberOfItemsInSection:section];
            }
        }
    }
    
    return items;
}

- (UIView *)dzn_customView
{
//    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(customViewForEmptyDataSet:)]) {
//        UIView *view = [self.emptyDataSetSource customViewForEmptyDataSet:self];
//        if (view) NSAssert([view isKindOfClass:[UIView class]], @"You must return a valid UIView object for -customViewForEmptyDataSet:");
//        return view;
//    }
    return nil;
}

- (CGFloat)dzn_verticalOffset
{
    CGFloat offset = 0.0;
    
//    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(verticalOffsetForEmptyDataSet:)]) {
//        offset = [self.emptyDataSetSource verticalOffsetForEmptyDataSet:self];
//    }
    return offset;
}

- (CGFloat)dzn_verticalSpace
{
//    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(spaceHeightForEmptyDataSet:)]) {
//        return [self.emptyDataSetSource spaceHeightForEmptyDataSet:self];
//    }
    return 0.0;
}

- (NSAttributedString *)dzn_buttonTitleForState:(UIControlState)state
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(placeholderViewForButton:)]) {
        NSAttributedString *string = [self.emptyDataSetSource placeholderViewForButton:self];
        if (string) NSAssert([string isKindOfClass:[NSAttributedString class]], @"You must return a valid NSAttributedString object for -buttonTitleForEmptyDataSet:forState:");
        return string;
    }
    return nil;
}

- (UIImage *)dzn_image
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(placeholderViewForImage:)]) {
        UIImage *image = [self.emptyDataSetSource placeholderViewForImage:self];
        if (image) NSAssert([image isKindOfClass:[UIImage class]], @"You must return a valid UIImage object for -imageForEmptyDataSet:");
        return image;
    }
    return nil;
}

- (UIColor *)dzn_dataSetBackgroundColor
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(placeholderViewForBackgroundColor:)]) {
        UIColor *color = [self.emptyDataSetSource placeholderViewForBackgroundColor:self];
        if (color) NSAssert([color isKindOfClass:[UIColor class]], @"You must return a valid UIColor object for -backgroundColorForEmptyDataSet:");
        return color;
    }
    return [UIColor clearColor];
}

#pragma mark - Delegate Getters & Events (Private)

- (BOOL)dzn_shouldFadeIn {
    return YES;
}

- (BOOL)dzn_shouldDisplay
{
//    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetShouldDisplay:)]) {
//        return [self.emptyDataSetDelegate emptyDataSetShouldDisplay:self];
//    }
    return YES;
}

- (BOOL)dzn_shouldBeForcedToDisplay
{
//    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetShouldBeForcedToDisplay:)]) {
//        return [self.emptyDataSetDelegate emptyDataSetShouldBeForcedToDisplay:self];
//    }
    return NO;
}

- (BOOL)dzn_isTouchAllowed
{
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(placeholderViewShouldAllowScroll:)]) {
        return [self.emptyDataSetDelegate placeholderViewShouldAllowScroll:self];
    }
    return YES;
}

- (BOOL)dzn_isScrollAllowed
{
    return YES;
}

- (BOOL)dzn_isImageViewAnimateAllowed
{
//    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetShouldAnimateImageView:)]) {
//        return [self.emptyDataSetDelegate emptyDataSetShouldAnimateImageView:self];
//    }
    return NO;
}

//- (void)dzn_willAppear
//{
//    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetWillAppear:)]) {
//        [self.emptyDataSetDelegate emptyDataSetWillAppear:self];
//    }
//}

//- (void)dzn_didAppear
//{
//    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetDidAppear:)]) {
//        [self.emptyDataSetDelegate emptyDataSetDidAppear:self];
//    }
//}

//- (void)dzn_willDisappear
//{
//    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetWillDisappear:)]) {
//        [self.emptyDataSetDelegate emptyDataSetWillDisappear:self];
//    }
//}

//- (void)dzn_didDisappear
//{
//    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetDidDisappear:)]) {
//        [self.emptyDataSetDelegate emptyDataSetDidDisappear:self];
//    }
//}

- (void)dzn_didTapContentView:(id)sender
{
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(placeholderView:didTapView:)]) {
        [self.emptyDataSetDelegate placeholderView:self didTapView:sender];
    }
}

- (void)dzn_didTapDataButton:(id)sender
{
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(placeholderView:didTapButton:)]) {
        [self.emptyDataSetDelegate placeholderView:self didTapButton:sender];
    }
}


#pragma mark - Setters (Public)

- (void)setEmptyDataSetSource:(id<PlaceholderViewDataSource>)datasource
{
    if (!datasource || ![self dzn_canDisplay]) {
        [self dzn_invalidate];
    }
    
    objc_setAssociatedObject(self, kEmptyDataSetSource, [[LSWeakObjectContainer alloc] initWithWeakObject:datasource], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // We add method sizzling for injecting -dzn_reloadData implementation to the native -reloadData implementation
    [self swizzleIfPossible:@selector(reloadData)];
    
    // Exclusively for UITableView, we also inject -dzn_reloadData to -endUpdates
    if ([self isKindOfClass:[UITableView class]]) {
        [self swizzleIfPossible:@selector(endUpdates)];
    }
}



- (void)setEmptyDataSetDelegate:(id<PlaceholderViewDelegate>)delegate
{
    if (!delegate) {
        [self dzn_invalidate];
    }
    
    objc_setAssociatedObject(self, kEmptyDataSetDelegate, [[LSWeakObjectContainer alloc] initWithWeakObject:delegate], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Setters (Private)

- (void)setEmptyDataSetView:(LSPlaceholderView *)view
{
    objc_setAssociatedObject(self, kEmptyDataSetView, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Reload APIs (Public)

- (void)reloadEmptyDataSet
{
    [self dzn_reloadEmptyDataSet];
}

#pragma mark - Reload APIs (Private)

- (void)dzn_reloadEmptyDataSet
{
    if (![self dzn_canDisplay]) {
        return;
    }
    
    if (([self dzn_shouldDisplay] && [self dzn_itemsCount] == 0) || [self dzn_shouldBeForcedToDisplay])
    {
        // Notifies that the empty dataset view will appear
//        [self dzn_willAppear];
        
        LSPlaceholderView *view = self.emptyDataSetView;
        
        if (!view.superview) {
            // Send the view all the way to the back, in case a header and/or footer is present, as well as for sectionHeaders or any other content
            if (([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]]) && self.subviews.count > 1) {
                [self insertSubview:view atIndex:0];
            }
            else {
                [self addSubview:view];
            }
        }
        
        // Removing view resetting the view and its constraints it very important to guarantee a good state
        [view prepareForReuse];
        
        UIView *customView = [self dzn_customView];
        
        // If a non-nil custom view is available, let's configure it instead
        if (customView) {
            view.customView = customView;
        }
        else {
            // Get the data from the data source
//            NSAttributedString *titleLabelString = [self dzn_titleLabelString];
//            NSAttributedString *detailLabelString = [self dzn_detailLabelString];
            
//            UIImage *buttonImage = [self dzn_buttonImageForState:UIControlStateNormal];
            NSAttributedString *buttonTitle = [self dzn_buttonTitleForState:UIControlStateNormal];
            
            UIImage *image = [self dzn_image];
//            UIColor *imageTintColor = [self dzn_imageTintColor];
            UIImageRenderingMode renderingMode = UIImageRenderingModeAlwaysOriginal;
            
            view.verticalSpace = [self dzn_verticalSpace];
            
            // Configure Image
            if (image) {
                if ([image respondsToSelector:@selector(imageWithRenderingMode:)]) {
                    view.imageView.image = [image imageWithRenderingMode:renderingMode];
//                    view.imageView.tintColor = imageTintColor;
                }
                else {
                    // iOS 6 fallback: insert code to convert imaged if needed
                    view.imageView.image = image;
                }
            }
            
            // Configure title label
//            if (titleLabelString) {
//                view.titleLabel.attributedText = titleLabelString;
//            }
//            
//            // Configure detail label
//            if (detailLabelString) {
//                view.detailLabel.attributedText = detailLabelString;
//            }
            
            // Configure button
//            if (buttonImage) {
//                [view.button setImage:buttonImage forState:UIControlStateNormal];
//                [view.button setImage:[self dzn_buttonImageForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
//            }
            else if (buttonTitle) {
                [view.button setAttributedTitle:buttonTitle forState:UIControlStateNormal];
//                [view.button setAttributedTitle:[self dzn_buttonTitleForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
//                [view.button setBackgroundImage:[self dzn_buttonBackgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
//                [view.button setBackgroundImage:[self dzn_buttonBackgroundImageForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
            }
        }
        
        // Configure offset
        view.verticalOffset = [self dzn_verticalOffset];
        
        // Configure the empty dataset view
        view.backgroundColor = [self dzn_dataSetBackgroundColor];
        view.hidden = NO;
        view.clipsToBounds = YES;
        
        // Configure empty dataset userInteraction permission
        view.userInteractionEnabled = [self dzn_isTouchAllowed];
        
        // Configure empty dataset fade in display
        view.fadeInOnDisplay = [self dzn_shouldFadeIn];
        
        [view setupConstraints];
        
        [UIView performWithoutAnimation:^{
            [view layoutIfNeeded];
        }];
        
        // Configure scroll permission
        self.scrollEnabled = [self dzn_isScrollAllowed];
        
        // Configure image view animation
//        if ([self dzn_isImageViewAnimateAllowed])
//        {
//            CAAnimation *animation = [self dzn_imageAnimation];
//            
//            if (animation) {
//                [self.emptyDataSetView.imageView.layer addAnimation:animation forKey:kEmptyImageViewAnimationKey];
//            }
//        }
//        else
            if ([self.emptyDataSetView.imageView.layer animationForKey:kEmptyImageViewAnimationKey]) {
            [self.emptyDataSetView.imageView.layer removeAnimationForKey:kEmptyImageViewAnimationKey];
        }
        
        // Notifies that the empty dataset view did appear
//        [self dzn_didAppear];
    }
    else if (self.isEmptyDataSetVisible) {
        [self dzn_invalidate];
    }
}

- (void)dzn_invalidate
{
    // Notifies that the empty dataset view will disappear
//    [self dzn_willDisappear];
    
    if (self.emptyDataSetView) {
        [self.emptyDataSetView prepareForReuse];
        [self.emptyDataSetView removeFromSuperview];
        
        [self setEmptyDataSetView:nil];
    }
    
    self.scrollEnabled = YES;
    
    // Notifies that the empty dataset view did disappear
//    [self dzn_didDisappear];
}


#pragma mark - Method Swizzling

static NSMutableDictionary *_impLookupTable;
static NSString *const DZNSwizzleInfoPointerKey = @"pointer";
static NSString *const DZNSwizzleInfoOwnerKey = @"owner";
static NSString *const DZNSwizzleInfoSelectorKey = @"selector";

void dzn_original_implementation(id self, SEL _cmd)
{
    // Fetch original implementation from lookup table
    NSString *key = dzn_implementationKey(self, _cmd);
    
    NSDictionary *swizzleInfo = [_impLookupTable objectForKey:key];
    NSValue *impValue = [swizzleInfo valueForKey:DZNSwizzleInfoPointerKey];
    
    IMP impPointer = [impValue pointerValue];
    
    // We then inject the additional implementation for reloading the empty dataset
    // Doing it before calling the original implementation does update the 'isEmptyDataSetVisible' flag on time.
    [self dzn_reloadEmptyDataSet];
    
    // If found, call original implementation
    if (impPointer) {
        ((void(*)(id,SEL))impPointer)(self,_cmd);
    }
}

NSString *dzn_implementationKey(id target, SEL selector)
{
    if (!target || !selector) {
        return nil;
    }
    
    Class baseClass;
    if ([target isKindOfClass:[UITableView class]]) baseClass = [UITableView class];
    else if ([target isKindOfClass:[UICollectionView class]]) baseClass = [UICollectionView class];
    else if ([target isKindOfClass:[UIScrollView class]]) baseClass = [UIScrollView class];
    else return nil;
    
    NSString *className = NSStringFromClass([baseClass class]);
    
    NSString *selectorName = NSStringFromSelector(selector);
    return [NSString stringWithFormat:@"%@_%@",className,selectorName];
}

- (void)swizzleIfPossible:(SEL)selector
{
    // Check if the target responds to selector
    if (![self respondsToSelector:selector]) {
        return;
    }
    
    // Create the lookup table
    if (!_impLookupTable) {
        _impLookupTable = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    
    // We make sure that setImplementation is called once per class kind, UITableView or UICollectionView.
    for (NSDictionary *info in [_impLookupTable allValues]) {
        Class class = [info objectForKey:DZNSwizzleInfoOwnerKey];
        NSString *selectorName = [info objectForKey:DZNSwizzleInfoSelectorKey];
        
        if ([selectorName isEqualToString:NSStringFromSelector(selector)]) {
            if ([self isKindOfClass:class]) {
                return;
            }
        }
    }
    
    NSString *key = dzn_implementationKey(self, selector);
    NSValue *impValue = [[_impLookupTable objectForKey:key] valueForKey:DZNSwizzleInfoPointerKey];
    
    // If the implementation for this class already exist, skip!!
    if (impValue || !key) {
        return;
    }
    
    // Swizzle by injecting additional implementation
    Method method = class_getInstanceMethod([self class], selector);
    IMP dzn_newImplementation = method_setImplementation(method, (IMP)dzn_original_implementation);
    
    // Store the new implementation in the lookup table
    NSDictionary *swizzledInfo = @{DZNSwizzleInfoOwnerKey: [self class],
                                   DZNSwizzleInfoSelectorKey: NSStringFromSelector(selector),
                                   DZNSwizzleInfoPointerKey: [NSValue valueWithPointer:dzn_newImplementation]};
    
    [_impLookupTable setObject:swizzledInfo forKey:key];
}


#pragma mark - UIGestureRecognizerDelegate Methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return ![touch.view isKindOfClass:[UIControl class]];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer.view isEqual:self.emptyDataSetView]) {
        return [self dzn_isTouchAllowed];
    }
    
    return [super gestureRecognizerShouldBegin:gestureRecognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    UIGestureRecognizer *tapGesture = self.emptyDataSetView.tapGesture;
    
    if ([gestureRecognizer isEqual:tapGesture] || [otherGestureRecognizer isEqual:tapGesture]) {
        return YES;
    }
    
    // defer to emptyDataSetDelegate's implementation if available
    if ( (self.emptyDataSetDelegate != (id)self) && [self.emptyDataSetDelegate respondsToSelector:@selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)]) {
        return [(id)self.emptyDataSetDelegate gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    
    return NO;
}


@end
