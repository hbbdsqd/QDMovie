//
//  QDCountDownButton.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/15.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QDCountDownButton;
typedef NSString* (^DidChangeBlock)(QDCountDownButton *countDownButton,int second);
typedef NSString* (^DidFinishedBlock)(QDCountDownButton *countDownButton,int second);

typedef void (^TouchedDownBlock)(QDCountDownButton *countDownButton,NSInteger tag);



@interface QDCountDownButton : UIButton{
    int _second;
    int _totalSecond;
    
    NSTimer *_timer;
    DidChangeBlock _didChangeBlock;
    DidFinishedBlock _didFinishedBlock;
    TouchedDownBlock _touchedDownBlock;
}
-(void)addToucheHandler:(TouchedDownBlock)touchHandler;
-(void)didChange:(DidChangeBlock)didChangeBlock;
-(void)didFinished:(DidFinishedBlock)didFinishedBlock;
-(void)startWithSecond:(int)second;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
