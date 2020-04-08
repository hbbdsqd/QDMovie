//
//  SQButtonTagView.h
//  SQButtonTagView
//
//  Created by yangsq on 2017/9/26.
//  Copyright © 2017年 yangsq. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SQButtonTagView : UIView

NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, strong) NSArray *tagTexts;
@property (assign, nonatomic) NSInteger eachNum;
@property (nonatomic, assign) NSInteger maxSelectNum;//最大选择个数
@property (nonatomic, copy) void(^selectBlock)(SQButtonTagView *tagView, NSArray *selectArray,NSString *text);

/**
 初始化方法

 @param totalTagsNum 最多可以显示多少个tag
 @param viewWidth 视图的宽度
 @param eachNum 0的时候每个tag的大小根据文字长度自适应
 @param hmargin 水平间距
 @param vmargin 垂直间距
 @param tagHeight tag的高度
 @param tagTextFont 文字的大小
 @param tagTextColor 未选择时的文字颜色
 @param selectedTagTextColor 选择时的文字颜色
 @param selectedBackgroundColor 选择后的背景颜色
 */
- (id)initWithTotalTagsNum:(NSInteger)totalTagsNum
                 viewWidth:(CGFloat)viewWidth
                   eachNum:(NSInteger)eachNum
                   Hmargin:(CGFloat)hmargin
                   Vmargin:(CGFloat)vmargin
                 tagHeight:(CGFloat)tagHeight
               tagTextFont:(UIFont *)tagTextFont
              tagTextColor:(UIColor *)tagTextColor
      selectedTagTextColor:(UIColor *)selectedTagTextColor
   selectedBackgroundColor:(UIColor *)selectedBackgroundColor;

//返回高度
+ (CGFloat)returnViewHeightWithTagTexts:(NSArray *)tagTexts
                              viewWidth:(CGFloat)viewWidth
                                eachNum:(NSInteger)eachNum
                                Hmargin:(CGFloat)hmargin
                                Vmargin:(CGFloat)vmargin
                              tagHeight:(CGFloat)tagHeight
                            tagTextFont:(UIFont *)tagTextFont;


//点击回调
- (void)selectAction:(void(^)(SQButtonTagView *tagView, NSArray *selectArray,NSString *text))block;


NS_ASSUME_NONNULL_END

@end
