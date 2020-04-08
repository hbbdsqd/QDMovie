//
//  SQButtonTagView.m
//  SQButtonTagView
//
//  Created by yangsq on 2017/9/26.
//  Copyright © 2017年 yangsq. All rights reserved.
//

#import "SQButtonTagView.h"


@interface SQButtonTagView ()

@property (assign, nonatomic) NSInteger totalTagsNum;
@property (assign, nonatomic) CGFloat hmargin;
@property (assign, nonatomic) CGFloat vmargin;
@property (assign, nonatomic) CGFloat viewWidth;
@property (assign, nonatomic) CGFloat tagHeight;
@property (strong, nonatomic) NSMutableArray *buttonTags;
@property (strong, nonatomic) UIFont *tagTextFont;
@property (strong, nonatomic) UIColor *tagTextColor;
@property (strong, nonatomic) UIColor *selectedTagTextColor;
@property (strong, nonatomic) UIColor *selectedBackgroundColor;

@property (strong, nonatomic) NSMutableArray *selectArray;


@end

@implementation SQButtonTagView

- (void)dealloc{
    _buttonTags = nil;
    _tagTextFont = nil;
    _selectedTagTextColor = nil;
    _selectArray = nil;
}


- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = @[].mutableCopy;
    }
    return _selectArray;
}

- (id)initWithTotalTagsNum:(NSInteger)totalTagsNum
                 viewWidth:(CGFloat)viewWidth
                   eachNum:(NSInteger)eachNum
                   Hmargin:(CGFloat)hmargin
                   Vmargin:(CGFloat)vmargin
                 tagHeight:(CGFloat)tagHeight
               tagTextFont:(UIFont *)tagTextFont
              tagTextColor:(nonnull UIColor *)tagTextColor
      selectedTagTextColor:(nonnull UIColor *)selectedTagTextColor
   selectedBackgroundColor:(UIColor *)selectedBackgroundColor{
    
    if (self = [super init]) {
        self.totalTagsNum = totalTagsNum;
        self.eachNum = eachNum;
        self.hmargin = hmargin;
        self.vmargin = vmargin;
        self.viewWidth = viewWidth;
        self.tagHeight = tagHeight;
        self.tagTextFont = tagTextFont;
        self.buttonTags = @[].mutableCopy;
        self.tagTextColor = tagTextColor;
        self.selectedTagTextColor = selectedTagTextColor;
        self.selectedBackgroundColor = selectedBackgroundColor;

        for (NSInteger i=0; i<totalTagsNum; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.layer.cornerRadius = 4;
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitleColor:tagTextColor forState:UIControlStateNormal];
            button.titleLabel.font = tagTextFont;
            button.titleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
            [self addSubview:button];
            [self.buttonTags addObject:button];
            button.tag = 101+i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
        }
        self.backgroundColor = QDColorWhite;

    }
    
    return self;
}

+ (CGFloat)returnViewHeightWithTagTexts:(NSArray *)tagTexts viewWidth:(CGFloat)viewWidth eachNum:(NSInteger)eachNum Hmargin:(CGFloat)hmargin Vmargin:(CGFloat)vmargin tagHeight:(CGFloat)tagHeight tagTextFont:(UIFont *)tagTextFont{
    CGFloat Height = 0;
    if (eachNum>0) {
        if (tagTexts.count>0) {
            NSInteger a = tagTexts.count/eachNum;
            NSInteger b = tagTexts.count%eachNum;
            if (b>0&&a>=0) {
                a+=1;
            }
            Height = a*tagHeight + (a-1)*vmargin;
        }
        
    }else{
        CGFloat totalWith = 0;
        NSInteger row = 0;
        for (NSInteger i=0; i<tagTexts.count; i++) {
            NSString *tempString = tagTexts[i];
            CGFloat itemWidth = [[self alloc]sizeForText:tempString Font:tagTextFont size:CGSizeMake(140, tagHeight) mode:NSLineBreakByWordWrapping].width+20;
            totalWith +=itemWidth+hmargin;
            if (totalWith-hmargin>viewWidth) {
                totalWith = itemWidth+hmargin;
                row+=1;
            }
        }
        
        Height = tagHeight*(row+1)+row*vmargin;
    }
    
    return Height;
}


- (void)setTagTexts:(NSArray *)tagTexts{
    if (self.eachNum>0) {
        
        CGFloat with = (self.viewWidth-(self.eachNum-1)*self.hmargin)/self.eachNum;
        
        
        for (NSInteger i=0; i<self.buttonTags.count; i++) {
            UIButton *button = self.buttonTags[i];
            if (i<tagTexts.count) {
                [button setTitle:tagTexts[i] forState:UIControlStateNormal];
                NSInteger a = i/self.eachNum;
                NSInteger b = i%self.eachNum;
                button.frame = (CGRect){b*(with+self.hmargin),a*(self.tagHeight+self.vmargin),with,self.tagHeight};
                [button setHidden:NO];
                [button setTitle:tagTexts[i] forState:UIControlStateNormal];
                [button setBackgroundColor:QDGetColor(@"f4f4f4")];
                
            }else{
                [button setHidden:YES];
                [button setBackgroundColor:[UIColor whiteColor]];
            }
        }
    }else{
        
        __block CGFloat totalWidth = 0;
        __block NSInteger row = 0;
        [self.buttonTags enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx<tagTexts.count) {
                NSString *tempString = tagTexts[idx];
                [button setTitle:tempString forState:UIControlStateNormal];
                CGFloat itemWidth = [self sizeForText:tempString Font:self.tagTextFont size:CGSizeMake(140, self.tagHeight) mode:NSLineBreakByWordWrapping].width+20;
              
                totalWidth+=itemWidth+self.hmargin;
                if (totalWidth-self.hmargin>self.viewWidth) {
                    totalWidth = itemWidth+self.hmargin;
                    row+=1;
                    button.frame = CGRectMake(0, row*(self.tagHeight+self.vmargin), itemWidth, self.tagHeight);
                }else{
                    button.frame = CGRectMake(totalWidth-itemWidth-self.hmargin, row*(self.tagHeight+self.vmargin), itemWidth, self.tagHeight);
                }
                [button setHidden:NO];
                [button setTitle:tagTexts[idx] forState:UIControlStateNormal];
                [button setBackgroundColor:QDGetColor(@"f4f4f4")];
                
            }else{
                [button setHidden:YES];
                [button setBackgroundColor:[UIColor whiteColor]];
                
            }
            
            
        }];
        
    }

}



- (void)buttonAction:(UIButton *)button{
    
   
    NSInteger tag = button.tag-101;
    
    if ([self.selectArray containsObject:@(tag)]) {
        [self.selectArray removeObject:@(tag)];
    }else{
        if (self.selectArray.count==self.maxSelectNum&&self.maxSelectNum>0) {
            NSLog(@"最多选择%@",[NSString stringWithFormat:@"%ld个",self.maxSelectNum]);
        }else{
            [self.selectArray addObject:button.titleLabel.text];
        }
    }
    if (self.selectBlock) {
//        self.selectBlock(self, self.selectArray.copy);
        self.selectBlock(self, self.selectArray, button.titleLabel.text);
    }
    
    [self refreshView];
}

-(void)selectAction:(void (^)(SQButtonTagView * _Nonnull, NSArray * _Nonnull, NSString * _Nonnull))block{
    self.selectBlock = block;
}


- (void)refreshView{
    
    for (UIButton *buttonTag in self.buttonTags) {
        if ([self.selectArray containsObject:@(buttonTag.tag-101)]) {
            [buttonTag setBackgroundColor:self.selectedBackgroundColor];
            [buttonTag setTitleColor:self.selectedTagTextColor forState:UIControlStateNormal];
            buttonTag.layer.borderColor = self.selectedBackgroundColor.CGColor;
        }else{
            [buttonTag setBackgroundColor:nil];
            [buttonTag setTitleColor:self.tagTextColor forState:UIControlStateNormal];
            buttonTag.layer.borderColor = self.tagTextColor.CGColor;
        }
    }
}

- (CGSize)sizeForText:(NSString *)text Font:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [text boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [text sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
