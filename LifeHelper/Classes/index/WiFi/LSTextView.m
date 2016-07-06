//
//  LSTextView.m
//  LifeHelper
//
//  Created by Lost_souls on 16/6/27.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "LSTextView.h"

typedef NS_ENUM(NSInteger,LSTextViewDirection) {
    LSTextViewDirectionUp = 0,
    LSTextViewDirectionDown,
};

@interface LSTextView ()<UIGestureRecognizerDelegate>
{
    LSTextViewDirection _direction;
    CGPoint _beginContentOffset;
    
    CGPoint _point;
    UIEvent *_event;
}

@end

@implementation LSTextView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        _direction = LSTextViewDirectionUp;
        self.delegate = self;
    }
    
    return self;
}

// 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    _beginContentOffset = scrollView.contentOffset;
    NNLog(@"_beginContentOffset.y:%f",_beginContentOffset.y);
}
// 正在滚动...
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NNLog(@"y:%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > _beginContentOffset.y) {
        _direction = LSTextViewDirectionUp;
        if (self.contentOffset.y >= self.contentSize.height-self.frame.size.height) {
            self.scrollEnabled = NO;
            NNLog(@"up....%f",scrollView.contentOffset.y);
        }else{
            self.scrollEnabled = YES;
        }
    }else if (scrollView.contentOffset.y < _beginContentOffset.y){
        _direction = LSTextViewDirectionDown;
        if (self.contentOffset.y <= 0) {
            self.scrollEnabled = NO;
            NNLog(@"down....%f",scrollView.contentOffset.y);
        }else{
            self.scrollEnabled = YES;
        }
    }
}

// 拖动结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    self.scrollEnabled = YES;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    
//    NNLog(@"point(%f,%f)",point.x,point.y);
//    NNLog(@"event:%@",event);
//    
//    UITouch *touch = [[event allTouches] anyObject];
//    CGPoint currentLocation = [touch locationInView:self];
//    CGPoint previousLocation = [touch previousLocationInView:self];
//    
//    NNLog(@".....(%f,%f),(%f,%f)",currentLocation.x,currentLocation.y,previousLocation.x,previousLocation.y);
//    
//    NNLog(@"self.contentOffset.y:%f",self.contentOffset.y);
//    NNLog(@"self.contentSize.height:%f",self.contentSize.height - self.frame.size.height);
//    _point = point;
//    _event = event;
//    
//    BOOL up = self.contentOffset.y < 0 && _direction == LSTextViewDirectionUp;
//    BOOL down = (self.contentOffset.y > self.contentSize.height-self.frame.size.height) && _direction == LSTextViewDirectionDown;
//    NNLog(@"self.contentOffset.y:%f > %f,",self.contentOffset.y,self.contentSize.height-self.frame.size.height)
//    NNLog(@"_direction:%d",_direction == LSTextViewDirectionDown ? YES : NO)
//    NNLog(@"%d---%d",up,down)
//    if ( up || down) {
//        return self.superview;
//    }
//    
//    return [super hitTest:point withEvent:event];
//}



#pragma mark - UIGestureRecognizerDelegate

// called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to transition to UIGestureRecognizerStateFailed
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    
//    if ([gestureRecognizer.view isKindOfClass:[LSTextView class]]) {
//        
//        BOOL up = self.contentOffset.y < 0 && _direction == LSTextViewDirectionUp;
//        BOOL down = (self.contentOffset.y > self.contentSize.height-self.frame.size.height) && _direction == LSTextViewDirectionDown;
//        
//        if ( up || down) {
//            return NO;
//        }
//    }
//    
//    return YES;
//}

// called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
// return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
//
// note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    
//}

// called once per attempt to recognize, so failure requirements can be determined lazily and may be set up between recognizers across view hierarchies
// return YES to set up a dynamic failure requirement between gestureRecognizer and otherGestureRecognizer
//
// note: returning YES is guaranteed to set up the failure requirement. returning NO does not guarantee that there will not be a failure requirement as the other gesture's counterpart delegate or subclass methods may return YES
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0){
//    
//}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0){
//    
//}

// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    
//    BOOL up = self.contentOffset.y < 0 && _direction == LSTextViewDirectionUp;
//    BOOL down = (self.contentOffset.y > self.contentSize.height-self.frame.size.height) && _direction == LSTextViewDirectionDown;
//    
//    if ( up || down) {
//        return NO;
//    }
//    
//    return YES;
//}

// called before pressesBegan:withEvent: is called on the gesture recognizer for a new press. return NO to prevent the gesture recognizer from seeing this press
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press{
//
//    
//}


@end
